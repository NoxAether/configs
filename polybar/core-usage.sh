#!/usr/bin/env bash

# Previous state file
prev_file="/tmp/core-usage-$USER.prev"

# Initialize or read previous state
if [[ ! -f "$prev_file" ]]; then
    # First run - initialize state with zeros
    cores=()
    for i in {0..23}; do
        if line=$(grep -m1 "^cpu$i\\>" /proc/stat); then
            user=$(awk '{print $2}' <<< "$line")
            system=$(awk '{print $4}' <<< "$line")
            idle=$(awk '{print $5}' <<< "$line")
            echo "$i $user $system $idle" >> "$prev_file"
        else
            echo "$i 0 0 0" >> "$prev_file"
        fi
        cores+=("▁")
    done
else
    # Read previous values
    declare -a prev_vals
    while IFS= read -r line; do
        prev_vals+=("$line")
    done < "$prev_file"

    # Process current state
    : > "$prev_file"  # Clear previous file
    cores=()
    for i in {0..23}; do
        # Parse previous values
        prev=(${prev_vals[i]})
        p_user=${prev[1]}
        p_system=${prev[2]}
        p_idle=${prev[3]}

        # Get current values
        if line=$(grep -m1 "^cpu$i\\>" /proc/stat); then
            c_user=$(awk '{print $2}' <<< "$line")
            c_system=$(awk '{print $4}' <<< "$line")
            c_idle=$(awk '{print $5}' <<< "$line")

            # Store current state for next run
            echo "$i $c_user $c_system $c_idle" >> "$prev_file"

            # Calculate deltas
            u_diff=$((c_user - p_user))
            s_diff=$((c_system - p_system))
            i_diff=$((c_idle - p_idle))
            total=$((u_diff + s_diff + i_diff))

            # Compute usage percentage
            if (( total > 0 )); then
                usage=$(( (u_diff + s_diff) * 100 / total ))
            else
                usage=0
            fi

            # Convert to bar character
            if (( usage < 10 )); then    cores+=("▁")
            elif (( usage < 30 )); then  cores+=("▂")
            elif (( usage < 50 )); then  cores+=("▃")
            elif (( usage < 70 )); then  cores+=("▅")
            else                        cores+=("▇")
            fi
        else
            cores+=("▁")
            echo "$i 0 0 0" >> "$prev_file"
        fi
    done
fi

# Format output (unchanged)
block1="${cores[0]}${cores[1]}${cores[2]}${cores[3]}${cores[4]}${cores[5]}"
block2="${cores[6]}${cores[7]}${cores[8]}${cores[9]}${cores[10]}${cores[11]}"
block3="${cores[12]}${cores[13]}${cores[14]}${cores[15]}${cores[16]}${cores[17]}"
block4="${cores[18]}${cores[19]}${cores[20]}${cores[21]}${cores[22]}${cores[23]}"
echo "%{F#05d9ff}CORES%{F-}: $block1 $block2 $block3 $block4"
