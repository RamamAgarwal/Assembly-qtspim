# ================================================================
# OP-CODE: Your Personalized Student Life Manager
# Student: Ramam Agarwal | ID: U20230069 | BTech CSAI
# CS2011: Foundations of Computer Systems
# ================================================================

.data
# ===== STUDENT PROFILE DATA =====
student_id:         .word 20230069
student_name:       .asciiz "Ramam Agarwal"
program:            .asciiz "BTech CSAI"
current_cgpa:       .float 8.68
target_cgpa:        .float 9.1     # Realistic target with 3 semesters remaining
completed_credits:  .word 78
remaining_semesters: .word 3       # Semesters 5, 6, 7 (8th is internship)
semester_credits:   .word 24
remaining_credits:  .word 72       # 24 credits × 3 semesters
total_credits:      .word 160
current_day:        .asciiz "Monday"

# ===== PERSONALIZATION CONSTANTS =====
# Derived from ID: 20230069
timing_pattern:     .word 5        # (ID % 8) = 5 → Afternoon-heavy
personality_type:   .word 1        # (ID >> 2) % 4 = 1 → Athletic Scholar
study_pattern:      .word 2        # Sum(digits) % 5 = 2 → Early Bird
attendance_mode:    .word 1        # ID % 3 = 1 → Balanced approach

# ===== SCHEDULE DATA (Monday) =====
num_classes:        .word 4
class_times:        .word 900, 1200, 1400, 1400    # Start times (24hr format: 900 = 9:00 AM)
class_durations:    .word 90, 60, 90, 90           # Duration in minutes
class_names:        .asciiz "Deep Learning"
                    .asciiz "Theory of Computation"
                    .asciiz "Foundations of Computer Systems"
                    .asciiz "Theory of Computational Complexity"
class_rooms:        .asciiz "Room 2201"
                    .asciiz "Room 2202"
                    .asciiz "Room 2201"
                    .asciiz "Room 1101"

# ===== ATTENDANCE DATA =====
num_subjects:       .word 3
attendance_attended: .word 17, 34, 23              # Classes attended
attendance_total:    .word 19, 36, 24              # Total classes
subject_names:      .asciiz "Deep Learning"
                    .asciiz "Theory of Computation"
                    .asciiz "Foundations of Computer Systems"
attendance_cutoff:  .float 75.0                    # 75% cutoff

# ===== FORMATTING CONSTANTS =====
hundred:            .float 100.0
round_const:        .float 0.005      # For rounding to 2 decimals

# ===== TIME FORMATTING =====
am_label:           .asciiz " AM"
pm_label:           .asciiz " PM"

# ===== OUTPUT STRINGS =====
header:         .asciiz "\n========================================\n"
header2:        .asciiz "       OP-CODE: CAMPUS BUDDY\n"
header3:        .asciiz "========================================\n"
student_info:   .asciiz "Student: "
pipe:           .asciiz " | "
day_label:      .asciiz "Day: "
newline:        .asciiz "\n"
dash_line:      .asciiz "----------------------------------------\n"

schedule_hdr:   .asciiz "\n TODAY'S SCHEDULE\n"
time_format:    .asciiz " - "
location_pre:   .asciiz " | "
free_slot:      .asciiz "[FREE SLOT: "
free_slot_end:  .asciiz " minutes]\n"
suggest_pre:    .asciiz "   Suggestion: "

academic_hdr:   .asciiz "\n ACADEMIC OVERVIEW\n"
cgpa_label:     .asciiz "Current CGPA: "
credits_label:  .asciiz " | Credits: "
slash:          .asciiz "/"
target_label:   .asciiz "\nTarget CGPA: "
required_sgpa:  .asciiz " | Avg SGPA needed (next 3 sems): "
sgpa_warning:   .asciiz " [Achievable!]"
sgpa_impossible: .asciiz " [WARNING: Exceeds 10.0 - Impossible!]"

attend_hdr:     .asciiz "\n ATTENDANCE PLANNER\n"
attend_format:  .asciiz " classes ("
percent_sign:   .asciiz "%)"
need_label:     .asciiz "\n   Need "
of_next:        .asciiz " of next "
classes_label:  .asciiz " classes to reach 75%\n"
status_safe:    .asciiz " [SAFE]\n"
status_warning: .asciiz " [WARNING: Attend more!]\n"

activity_hdr:   .asciiz "\n SMART SUGGESTIONS (Athletic Scholar Profile)\n"
morning_study:  .asciiz "6:00-8:00 AM: Morning study session (Hostel)\n"
sports_suggest: .asciiz "Evening: Sports activity recommended (Cricket/Basketball)\n"
free_suggest:   .asciiz "Use gaps for: Quick workouts or revision\n"

personality_msg: .asciiz "\n PERSONALIZATION INFO\n"
personality_1:   .asciiz "Your Campus Personality: Athletic Scholar\n"
personality_2:   .asciiz "Timing Pattern: Afternoon-Heavy (Pattern 5)\n"
personality_3:   .asciiz "Study Style: Early Bird Special (Pattern 2)\n"
personality_4:   .asciiz "Attendance Mode: Balanced Approach\n"

menu_hdr:       .asciiz "\n========================================\n"
menu_txt:       .asciiz "System Ready - All features displayed above\n"
menu_end:       .asciiz "========================================\n\n"

# Helper strings
colon:          .asciiz ":"
space:          .asciiz " "

.text
.globl main

# ================================================================
# MAIN PROGRAM
# ================================================================
main:
    # Display header
    jal print_header
    
    # Display schedule
    jal display_schedule
    
    # Display academic overview
    jal display_academic
    
    # Display attendance planner
    jal display_attendance
    
    # Display activity suggestions
    jal display_activities
    
    # Display personalization info
    jal display_personalization
    
    # Exit program
    li $v0, 10
    syscall

# ================================================================
# PRINT FLOAT WITH 2 DECIMAL PLACES
# Input: $f12 = float value to print
# ================================================================
print_float_2dp:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Multiply by 100 and round
    l.s $f0, hundred
    mul.s $f1, $f12, $f0       # f1 = value * 100
    
    # Round by adding 0.5 and truncating
    li.s $f2, 0.5
    add.s $f1, $f1, $f2
    
    # Convert to integer
    cvt.w.s $f3, $f1           # f3 = integer part
    mfc1 $t0, $f3              # Move to integer register
    
    # Get integer part (divide by 100)
    div $t0, $t0, 100
    mflo $t1                   # Integer part
    mfhi $t2                   # Decimal part (2 digits)
    
    # Print integer part
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Print decimal point
    li $v0, 11
    li $a0, 46                 # ASCII for '.'
    syscall
    
    # Print decimal part (with leading zero if needed)
    li $v0, 1
    bge $t2, 10, print_decimal
    # Print leading zero
    li $a0, 0
    syscall
    
print_decimal:
    move $a0, $t2
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# PRINT HEADER
# ================================================================
print_header:
    # Print header lines
    li $v0, 4
    la $a0, header
    syscall
    
    la $a0, header2
    syscall
    
    la $a0, header3
    syscall
    
    # Print student info
    la $a0, student_info
    syscall
    
    la $a0, student_name
    syscall
    
    la $a0, space
    syscall
    
    la $a0, pipe
    syscall
    
    la $a0, space
    syscall
    
    # Print ID
    li $v0, 1
    lw $a0, student_id
    syscall
    
    # Print day
    li $v0, 4
    la $a0, space
    syscall
    
    la $a0, pipe
    syscall
    
    la $a0, space
    syscall
    
    la $a0, current_day
    syscall
    
    la $a0, newline
    syscall
    
    la $a0, dash_line
    syscall
    
    jr $ra

# ================================================================
# PRINT TIME IN 12-HOUR FORMAT WITH AM/PM
# Input: $a1 = time in HHMM format (e.g., 900, 1400)
# ================================================================
print_time_12hr:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a1, 4($sp)
    
    # Extract hours and minutes
    move $t0, $a1
    li $t1, 100
    div $t0, $t1
    mflo $t2               # hours (24hr format)
    mfhi $t3               # minutes
    
    # Determine AM/PM and convert to 12hr
    blt $t2, 12, is_am
    
    # PM case
    beq $t2, 12, print_12pm
    sub $t2, $t2, 12       # Convert to 12hr
    j print_12pm
    
is_am:
    beq $t2, 0, print_12am  # Midnight case
    j print_time_value
    
print_12am:
    li $t2, 12
    j print_time_value
    
print_12pm:
    # t2 already correct for 12 PM or converted PM hours
    
print_time_value:
    # Print hour
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Print colon
    li $v0, 4
    la $a0, colon
    syscall
    
    # Print minutes (with leading zero if needed)
    li $v0, 1
    blt $t3, 10, print_leading_zero
    move $a0, $t3
    syscall
    j print_am_pm
    
print_leading_zero:
    li $a0, 0
    syscall
    move $a0, $t3
    syscall
    
print_am_pm:
    # Determine AM/PM
    lw $t0, 4($sp)         # Reload original time
    li $t1, 100
    div $t0, $t1
    mflo $t2               # hours again
    
    li $v0, 4
    blt $t2, 12, print_am
    la $a0, pm_label
    syscall
    j time_done
    
print_am:
    la $a0, am_label
    syscall
    
time_done:
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

# ================================================================
# DISPLAY SCHEDULE
# ================================================================
display_schedule:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Print schedule header
    li $v0, 4
    la $a0, schedule_hdr
    syscall
    
    la $a0, dash_line
    syscall
    
    # Initialize loop counter
    li $t0, 0              # i = 0
    lw $t1, num_classes    # Load number of classes
    
schedule_loop:
    bge $t0, $t1, schedule_done
    
    # Save loop counter
    addi $sp, $sp, -8
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    
    # Get start time
    la $t2, class_times
    sll $t3, $t0, 2        # i * 4
    add $t2, $t2, $t3
    lw $t4, 0($t2)         # Load start time
    
    # Print start time in 12hr format
    move $a1, $t4
    jal print_time_12hr
    
    # Restore loop counter
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    
    # Print " - "
    li $v0, 4
    la $a0, time_format
    syscall
    
    # Calculate end time (add duration to start time)
    la $t2, class_durations
    sll $t3, $t0, 2
    add $t2, $t2, $t3
    lw $t5, 0($t2)         # duration in minutes
    
    # Get start time again
    la $t2, class_times
    add $t2, $t2, $t3
    lw $t4, 0($t2)
    
    # Convert start time to total minutes
    div $t4, $t4, 100
    mflo $t6               # start hours
    mfhi $t7               # start minutes
    mul $t6, $t6, 60       # hours to minutes
    add $t8, $t6, $t7      # total start minutes
    
    # Add duration
    add $t8, $t8, $t5      # end time in total minutes
    
    # Convert back to HHMM format
    div $t8, $t8, 60
    mflo $t6               # end hours
    mfhi $t7               # end minutes
    mul $t6, $t6, 100
    add $t9, $t6, $t7      # end time in HHMM format
    
    # Print end time
    move $a1, $t9
    jal print_time_12hr
    
    # Restore loop counter again
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8
    
    li $v0, 4
    la $a0, location_pre
    syscall
    
    # Print class name
    beq $t0, 0, print_class_0
    beq $t0, 1, print_class_1
    beq $t0, 2, print_class_2
    beq $t0, 3, print_class_3
    j skip_class_name
    
print_class_0:
    la $a0, class_names
    syscall
    j after_class_name
    
print_class_1:
    la $a0, class_names
    addi $a0, $a0, 14      # "Deep Learning" = 13 chars + 1 null
    syscall
    j after_class_name
    
print_class_2:
    la $a0, class_names
    addi $a0, $a0, 38      # + "Theory of Computation" = 23 chars + 1 null
    syscall
    j after_class_name
    
print_class_3:
    la $a0, class_names
    addi $a0, $a0, 73      # + "Foundations of Computer Systems" = 34 chars + 1 null
    syscall
    j after_class_name
    
after_class_name:
    li $v0, 4
    la $a0, location_pre
    syscall
    
    # Print room
    beq $t0, 0, print_room_0
    beq $t0, 1, print_room_1
    beq $t0, 2, print_room_2
    beq $t0, 3, print_room_3
    j skip_room
    
print_room_0:
    la $a0, class_rooms
    syscall
    j after_room
    
print_room_1:
    la $a0, class_rooms
    addi $a0, $a0, 10      # "Room 2201" = 9 chars + 1 null = 10
    syscall
    j after_room
    
print_room_2:
    la $a0, class_rooms
    addi $a0, $a0, 20      # 10 + "Room 2202" = 10 + 10 = 20
    syscall
    j after_room
    
print_room_3:
    la $a0, class_rooms
    addi $a0, $a0, 30      # 20 + "Room 2201" = 20 + 10 = 30
    syscall
    j after_room
    
after_room:
    li $v0, 4
    la $a0, newline
    syscall
    
skip_room:
skip_class_name:
    
    # Check for free slots between current and next class
    addi $t9, $t0, 1
    bge $t9, $t1, no_free_slot
    
    # Get next class start time
    la $t2, class_times
    sll $t3, $t9, 2
    add $t2, $t2, $t3
    lw $s0, 0($t2)         # Next class time
    
    # Calculate current class end time (already in HHMM format from earlier)
    # Convert both to minutes for comparison
    div $s0, $s0, 100
    mflo $s1               # next start hours
    mfhi $s2               # next start minutes
    mul $s1, $s1, 60
    add $s1, $s1, $s2      # next start in total minutes
    
    # Current end time already calculated in $t8 (total minutes)
    sub $s3, $s1, $t8      # gap in minutes
    
    # If gap > 0, show free slot
    ble $s3, 0, no_free_slot
    
    li $v0, 4
    la $a0, free_slot
    syscall
    
    li $v0, 1
    move $a0, $s3
    syscall
    
    li $v0, 4
    la $a0, free_slot_end
    syscall
    
    la $a0, suggest_pre
    syscall
    
    # Suggest based on gap duration (Athletic Scholar personality)
    blt $s3, 30, suggest_canteen_msg
    blt $s3, 90, suggest_sports_msg
    j suggest_hostel_msg
    
suggest_canteen_msg:
    li $v0, 4
    la $a0, space
    syscall
    j no_free_slot
    
suggest_sports_msg:
    li $v0, 4
    la $a0, space
    syscall
    j no_free_slot
    
suggest_hostel_msg:
    li $v0, 4
    la $a0, space
    syscall
    
no_free_slot:
    # Increment counter
    addi $t0, $t0, 1
    j schedule_loop

schedule_done:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# DISPLAY ACADEMIC OVERVIEW
# ================================================================
display_academic:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Print header
    li $v0, 4
    la $a0, academic_hdr
    syscall
    
    la $a0, dash_line
    syscall
    
    # Print current CGPA
    la $a0, cgpa_label
    syscall
    
    l.s $f12, current_cgpa
    jal print_float_2dp
    
    # Print credits
    li $v0, 4
    la $a0, credits_label
    syscall
    
    li $v0, 1
    lw $a0, completed_credits
    syscall
    
    li $v0, 4
    la $a0, slash
    syscall
    
    li $v0, 1
    lw $a0, total_credits
    syscall
    
    # Print target CGPA
    li $v0, 4
    la $a0, target_label
    syscall
    
    l.s $f12, target_cgpa
    jal print_float_2dp
    
    # Calculate required average SGPA over next 3 semesters
    # Formula: (Target_CGPA × Total_Credits_After - Current_CGPA × Completed_Credits) / Remaining_Credits
    # Remaining_Credits = 72 (24 × 3 semesters)
    
    li $v0, 4
    la $a0, required_sgpa
    syscall
    
    # Load values
    l.s $f0, target_cgpa        # f0 = 8.8
    l.s $f1, current_cgpa       # f1 = 8.68
    
    lw $t0, completed_credits   # t0 = 78
    lw $t1, remaining_credits   # t1 = 72 (24 × 3 semesters)
    add $t2, $t0, $t1           # t2 = 150 (total after 3 semesters)
    
    # Convert integers to float
    mtc1 $t0, $f2
    cvt.s.w $f2, $f2            # f2 = 78.0
    
    mtc1 $t1, $f3
    cvt.s.w $f3, $f3            # f3 = 72.0
    
    mtc1 $t2, $f4
    cvt.s.w $f4, $f4            # f4 = 150.0
    
    # Calculate: target * total_after
    mul.s $f5, $f0, $f4         # f5 = 8.8 × 150 = 1320
    
    # Calculate: current * completed
    mul.s $f6, $f1, $f2         # f6 = 8.68 × 78 = 677.04
    
    # Subtract
    sub.s $f7, $f5, $f6         # f7 = 1320 - 677.04 = 642.96
    
    # Divide by remaining credits (72)
    div.s $f8, $f7, $f3         # f8 = 642.96 / 72 = 8.93 (average SGPA needed)
    
    # Print result with 2 decimal places
    mov.s $f12, $f8
    jal print_float_2dp
    
    # Check if required SGPA > 10.0
    li.s $f9, 10.0
    c.le.s $f8, $f9             # Check if required SGPA <= 10.0
    bc1t sgpa_ok
    
    # SGPA > 10.0 - Impossible
    li $v0, 4
    la $a0, sgpa_impossible
    syscall
    j sgpa_check_done
    
sgpa_ok:
    li $v0, 4
    la $a0, sgpa_warning
    syscall
    
sgpa_check_done:
    li $v0, 4
    la $a0, newline
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# DISPLAY ATTENDANCE
# ================================================================
display_attendance:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Print header
    li $v0, 4
    la $a0, attend_hdr
    syscall
    
    la $a0, dash_line
    syscall
    
    # Loop through subjects
    li $t0, 0
    lw $t1, num_subjects
    
attend_loop:
    bge $t0, $t1, attend_done
    
    # Print subject name
    li $v0, 4
    beq $t0, 0, print_subj_0
    beq $t0, 1, print_subj_1
    beq $t0, 2, print_subj_2
    j skip_subject
    
print_subj_0:
    la $a0, subject_names
    syscall
    j after_subject
    
print_subj_1:
    la $a0, subject_names
    addi $a0, $a0, 14      # "Deep Learning" = 13 chars + 1 null
    syscall
    j after_subject
    
print_subj_2:
    la $a0, subject_names
    addi $a0, $a0, 38      # + "Theory of Computation" = 23 chars + 1 null
    syscall
    j after_subject
    
after_subject:
    li $v0, 4
    la $a0, colon
    syscall
    
    la $a0, space
    syscall
    
    # Print attended
    la $t2, attendance_attended
    sll $t3, $t0, 2
    add $t2, $t2, $t3
    lw $t4, 0($t2)
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    # Print slash
    li $v0, 4
    la $a0, slash
    syscall
    
    # Print total
    la $t2, attendance_total
    add $t2, $t2, $t3
    lw $t5, 0($t2)
    
    li $v0, 1
    move $a0, $t5
    syscall
    
    # Calculate percentage
    mul $t6, $t4, 100
    div $t6, $t5
    mflo $t7               # percentage
    
    # Print percentage
    li $v0, 4
    la $a0, attend_format
    syscall
    
    li $v0, 1
    move $a0, $t7
    syscall
    
    li $v0, 4
    la $a0, percent_sign
    syscall
    
    # Check if below 75%
    bge $t7, 75, status_ok
    
    # Calculate classes needed
    # Formula: ceiling((0.75 * (total + x) - attended) / 1)
    # Solve for x where attendance >= 75%
    # attended / (total + x) >= 0.75
    # attended >= 0.75 * (total + x)
    # attended >= 0.75 * total + 0.75x
    # attended - 0.75*total >= 0.75x
    # x >= (attended - 0.75*total) / 0.75
    # Simplified: x >= (4*attended - 3*total) / 3
    
    li $v0, 4
    la $a0, status_warning
    syscall
    
    # Print need message
    la $a0, need_label
    syscall
    
    # Calculate needed: (3*total - 4*attended) / 1
    # This gives minimum classes to attend to reach exactly 75%
    mul $t8, $t5, 3        # total * 3
    mul $t9, $t4, 4        # attended * 4
    sub $s0, $t8, $t9      # 3*total - 4*attended
    
    # If result is negative, already above 75% (shouldn't happen in this branch)
    blt $s0, 0, status_ok
    
    li $v0, 1
    move $a0, $s0
    syscall
    
    li $v0, 4
    la $a0, of_next
    syscall
    
    addi $s2, $s0, 5       # next N classes (estimate)
    li $v0, 1
    move $a0, $s2
    syscall
    
    li $v0, 4
    la $a0, classes_label
    syscall
    
    j next_subject
    
status_ok:
    li $v0, 4
    la $a0, status_safe
    syscall
    
next_subject:
skip_subject:
    addi $t0, $t0, 1
    j attend_loop

attend_done:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# DISPLAY ACTIVITIES
# ================================================================
display_activities:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $v0, 4
    la $a0, activity_hdr
    syscall
    
    la $a0, dash_line
    syscall
    
    # Personalized suggestions based on Athletic Scholar profile
    la $a0, morning_study
    syscall
    
    la $a0, sports_suggest
    syscall
    
    la $a0, free_suggest
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# DISPLAY PERSONALIZATION INFO
# ================================================================
display_personalization:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $v0, 4
    la $a0, personality_msg
    syscall
    
    la $a0, dash_line
    syscall
    
    la $a0, personality_1
    syscall
    
    la $a0, personality_2
    syscall
    
    la $a0, personality_3
    syscall
    
    la $a0, personality_4
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# PRINT FOOTER
# ================================================================
print_footer:
    li $v0, 4
    la $a0, menu_hdr
    syscall
    
    la $a0, menu_txt
    syscall
    
    la $a0, menu_end
    syscall
    
    jr $ra

# ================================================================
# END OF PROGRAM
# ================================================================