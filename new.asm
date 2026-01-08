# ================================================================
# OP-CODE: Campus Buddy - ENHANCED OUTPUT FORMAT
# ================================================================
.data
# ===== PROFILE DATA =====
student_id: .asciiz "U20230069"
student_name: .asciiz "Ramam Agarwal"
current_cgpa: .float 8.68
completed_credits: .word 78
remaining_credits: .word 96
total_credits: .word 174
current_semester: .word 5
# Input
day_input: .space 20
# Monday Schedule
mon_times: .word 900, 1200, 1400
mon_durations: .word 90, 60, 90
mon_subj_list: .word dl, toc, fcs
mon_room_list: .word r2201, r2202, r2201
mon_count: .word 3
# Tuesday
tue_times: .word 1400
tue_durations: .word 90
tue_subj_list: .word SMAI
tue_room_list: .word r1001b
tue_count: .word 1
# Wednesday
wed_times: .word 900, 1200, 1400
wed_durations: .word 90, 60, 90
wed_count: .word 3
# Thursday
thu_times: .word 1400
thu_durations: .word 90
thu_count: .word 1
# Friday
fri_times: .word 1100, 1200, 1600
fri_durations: .word 60, 60, 60
fri_subj_list: .word smait, toc2, toct
fri_room_list: .word r2201, r2202, r2201
fri_count: .word 3
# Attendance (SMIA excluded)
att_subj_list: .word dl, toc, fcs
att_attended: .word 17, 34, 23
att_total: .word 19, 36, 24
att_count: .word 3
# String Data
dl: .asciiz "Deep Learning"
toc: .asciiz "Theory of Computation"
fcs: .asciiz "Foundations of Computer Systems"
smia: .asciiz "Search Methods in AI"
smiat: .asciiz "Search Methods in AI Tutorial"
toc2: .asciiz "Theory of Computation"
toct: .asciiz "Theory of Computation Tutorial"
r2201: .asciiz "Room 2201"
r2202: .asciiz "Room 2202"
r1001b: .asciiz "Room 1001(B)"
# UI STRINGS
prompt_cgpa: .asciiz "\nEnter target CGPA (for end of 8 semesters): "
prompt_day: .asciiz "Enter day (Monday/Tuesday/Wednesday/Thursday/Friday): "
msg_header: .asciiz "\n===================================\n=== CAMPUS BUDDY - YOUR SMART ACADEMIC ASSISTANT ===\n===================================\n"
msg_student: .asciiz "Student: "
msg_id: .asciiz " ["
msg_close_bracket: .asciiz "]"
msg_day: .asciiz " | Day: "
msg_sem: .asciiz " | Semester: "
msg_today_schedule: .asciiz "\n\n[TODAY'S SCHEDULE]\n"
msg_academic_hdr: .asciiz "\n\n[ACADEMIC OVERVIEW]\n"
msg_attendance_hdr: .asciiz "\n\n[ATTENDANCE PLANNER]\n"
msg_suggestions: .asciiz "\n\n[SMART SUGGESTIONS]\n"
msg_menu: .asciiz "\n\n[MENU]\n[1] View Schedule [2] Check Grades [3] Attendance [4] Suggestions [5] Exit\n"
msg_current: .asciiz "Current CGPA: "
msg_credits: .asciiz " | Completed Credits: "
msg_target: .asciiz "\nTarget CGPA (End of 8 semesters): "
msg_required: .asciiz " | Required SGPA this semester: "
msg_achievable: .asciiz " [ACHIEVABLE]"
msg_impossible: .asciiz " [REQUIRES FOCUS - Max possible: "
msg_time_sep: .asciiz " - "
msg_pipe: .asciiz " | "
msg_newline: .asciiz "\n"
msg_colon: .asciiz ": "
msg_am: .asciiz " AM"
msg_pm: .asciiz " PM"
msg_slash: .asciiz "/"
msg_percent: .asciiz "%"
msg_space: .asciiz " "
msg_dash: .asciiz "-----------------------------------\n"
msg_free_slot: .asciiz "[Free Slot] "
msg_suggestion: .asciiz " -> Suggestion: "
msg_note: .asciiz "(Note: SMAI has no attendance policy)\n"
msg_morning_study: .asciiz "- Morning Study Session (6:00 AM - 8:00 AM): Review yesterday's lectures\n"
msg_evening_sports: .asciiz "- Evening Sports/Workout (5:00 PM - 6:30 PM): Stay physically active\n"
msg_library: .asciiz "- Library Hours (Post-classes): Focus on difficult topics\n"
msg_revision: .asciiz "- Quick Revision: Utilize gaps between classes effectively\n"
msg_assignment: .asciiz "- Assignment Deadline Tracker: Check upcoming submissions\n"
# Free slot suggestions
suggest_morning: .asciiz "Quick revision or breakfast"
suggest_lunch: .asciiz "Lunch break - Network with peers"
suggest_afternoon: .asciiz "Library study session"
suggest_evening: .asciiz "Lab work or group discussion"
# Error messages
invalid_day_msg: .asciiz "Invalid Input, Please enter a valid day.\n"
invalid_cgpa_msg: .asciiz "Invalid CGPA entered. Target must be greater than current CGPA.\n"
# Constants
hundred_const: .float 100.0
max_sgpa: .float 10.0
min_attendance: .float 75.0
.text
.globl main
# ================================================================
main:
    # Print header
    li $v0, 4
    la $a0, msg_header
    syscall
   
    # Print basic student info
    li $v0, 4
    la $a0, msg_student
    syscall
    la $a0, student_name
    syscall
    la $a0, msg_id
    syscall
    la $a0, student_id
    syscall
    la $a0, msg_close_bracket
    syscall
    li $v0, 4
    la $a0, msg_newline
    syscall
   
    # Print current CGPA
    li $v0, 4
    la $a0, msg_current
    syscall
    l.s $f12, current_cgpa
    jal print_float
    li $v0, 4
    la $a0, msg_newline
    syscall
   
    # Get target CGPA
    li $v0, 4
    la $a0, prompt_cgpa
    syscall
   
    li $v0, 6
    syscall
    mov.s $f10, $f0
   
    # Validate target CGPA
    l.s $f0, current_cgpa
    c.lt.s $f10, $f0
    bc1t cgpa_invalid
   
    # Get day
    li $v0, 4
    la $a0, prompt_day
    syscall
   
    li $v0, 8
    la $a0, day_input
    li $a1, 20
    syscall
   
    jal clean_input
   
    # Print day and semester
    li $v0, 4
    la $a0, msg_day
    syscall
    la $a0, day_input
    syscall
    li $v0, 4
    la $a0, msg_sem
    syscall
    li $v0, 1
    lw $a0, current_semester
    syscall
    li $v0, 4
    la $a0, msg_newline
    syscall
   
    jal show_schedule_enhanced
    jal show_academic_enhanced
    jal show_attendance_enhanced
    jal show_suggestions_enhanced
    jal show_menu
   
    li $v0, 10
    syscall

cgpa_invalid:
    li $v0, 4
    la $a0, invalid_cgpa_msg
    syscall
    li $v0, 10
    syscall

# ================================================================
# INPUT CLEANING
# ================================================================
clean_input:
    la $t0, day_input
clean_loop:
    lb $t1, 0($t0)
    beqz $t1, clean_done
    li $t2, 10
    beq $t1, $t2, clean_replace
    li $t2, 13
    beq $t1, $t2, clean_replace
    addi $t0, $t0, 1
    j clean_loop
clean_replace:
    sb $zero, 0($t0)
clean_done:
    jr $ra
# ================================================================
# ENHANCED SCHEDULE WITH FREE SLOTS
# ================================================================
show_schedule_enhanced:
    addi $sp, $sp, -28
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
   
    li $v0, 4
    la $a0, msg_today_schedule
    syscall
    la $a0, msg_dash
    syscall
   
    # Match day
    la $t0, day_input
    lb $t1, 0($t0)
   
    li $t2, 'M'
    beq $t1, $t2, monday
    li $t2, 'm'
    beq $t1, $t2, monday
    li $t2, 'T'
    beq $t1, $t2, check_tue
    li $t2, 't'
    beq $t1, $t2, check_tue
    li $t2, 'W'
    beq $t1, $t2, wednesday
    li $t2, 'w'
    beq $t1, $t2, wednesday
    li $t2, 'F'
    beq $t1, $t2, friday
    li $t2, 'f'
    beq $t1, $t2, friday
    j invalid_day_print
check_tue:
    lb $t1, 1($t0)
    li $t2, 'h'
    beq $t1, $t2, thursday
    li $t2, 'H'
    beq $t1, $t2, thursday
    j tuesday
monday:
    li $s0, 3
    la $s1, mon_times
    la $s2, mon_durations
    la $s3, mon_subj_list
    la $s4, mon_room_list
    j schedule_loop
tuesday:
    li $s0, 1
    la $s1, tue_times
    la $s2, tue_durations
    la $s3, tue_subj_list
    la $s4, tue_room_list
    j schedule_loop
wednesday:
    li $s0, 3
    la $s1, wed_times
    la $s2, wed_durations
    la $s3, mon_subj_list
    la $s4, mon_room_list
    j schedule_loop
thursday:
    li $s0, 1
    la $s1, thu_times
    la $s2, thu_durations
    la $s3, tue_subj_list
    la $s4, tue_room_list
    j schedule_loop
friday:
    li $s0, 3
    la $s1, fri_times
    la $s2, fri_durations
    la $s3, fri_subj_list
    la $s4, fri_room_list
    j schedule_loop
invalid_day_print:
    li $v0, 4
    la $a0, invalid_day_msg
    syscall
    li $v0, 10
    syscall
schedule_loop:
    li $t5, 0
    li $s5, 0 # Previous end time
   
schedule_next:
    bge $t5, $s0, schedule_done
   
    # Check for free slot
    sll $t6, $t5, 2
    add $t7, $s1, $t6
    lw $t8, 0($t7) # Current start time
   
    beqz $t5, skip_free_slot
    bge $s5, $t8, skip_free_slot
   
    # Print free slot
    li $v0, 4
    la $a0, msg_free_slot
    syscall
   
    move $a0, $s5
    jal print_time
   
    li $v0, 4
    la $a0, msg_time_sep
    syscall
   
    move $a0, $t8
    jal print_time
   
    li $v0, 4
    la $a0, msg_suggestion
    syscall
   
    # Suggest based on time
    blt $s5, 1100, suggest_morning_slot
    blt $s5, 1400, suggest_lunch_slot
    la $a0, suggest_afternoon
    j print_suggest
   
suggest_morning_slot:
    la $a0, suggest_morning
    j print_suggest
   
suggest_lunch_slot:
    la $a0, suggest_lunch
   
print_suggest:
    li $v0, 4
    syscall
    la $a0, msg_newline
    syscall
   
skip_free_slot:
    # Print class
    sll $t6, $t5, 2
    add $t7, $s1, $t6
    lw $a0, 0($t7)
    jal print_time
   
    li $v0, 4
    la $a0, msg_time_sep
    syscall
   
    # Calculate end time
    sll $t6, $t5, 2
    add $t7, $s2, $t6
    lw $t8, 0($t7)
    add $t7, $s1, $t6
    lw $t9, 0($t7)
   
    div $t9, $t9, 100
    mflo $t6
    mfhi $t7
    mul $t6, $t6, 60
    add $t6, $t6, $t7
    add $t6, $t6, $t8
   
    div $t6, $t6, 60
    mflo $t7
    mfhi $t8
    mul $t7, $t7, 100
    add $a0, $t7, $t8
    move $s5, $a0 # Save end time
   
    jal print_time
   
    # Subject and room
    li $v0, 4
    la $a0, msg_pipe
    syscall
   
    sll $t6, $t5, 2
    add $t7, $s3, $t6
    lw $t7, 0($t7)
    move $a0, $t7
    li $v0, 4
    syscall
   
    li $v0, 4
    la $a0, msg_pipe
    syscall
   
    sll $t6, $t5, 2
    add $t7, $s4, $t6
    lw $t7, 0($t7)
    move $a0, $t7
    li $v0, 4
    syscall
   
    li $v0, 4
    la $a0, msg_newline
    syscall
   
    addi $t5, $t5, 1
    j schedule_next
   
schedule_done:
    # Check for evening free time
    li $t0, 1700
    bge $s5, $t0, no_evening_slot
   
    li $v0, 4
    la $a0, msg_free_slot
    syscall
   
    move $a0, $s5
    jal print_time
   
    li $v0, 4
    la $a0, msg_time_sep
    syscall
   
    li $a0, 1700
    jal print_time
   
    li $v0, 4
    la $a0, msg_suggestion
    syscall
    la $a0, suggest_evening
    syscall
    la $a0, msg_newline
    syscall
   
no_evening_slot:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    addi $sp, $sp, 28
    jr $ra
# ================================================================
# TIME PRINTER
# ================================================================
print_time:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
   
    move $t0, $a0
    li $t1, 100
    div $t0, $t1
    mflo $t2
    mfhi $t3
   
    blt $t2, 12, time_am
   
    beq $t2, 12, time_pm_noon
    sub $t2, $t2, 12
   
time_pm_noon:
    li $v0, 1
    move $a0, $t2
    syscall
   
    li $v0, 4
    la $a0, msg_colon
    syscall
   
    li $v0, 1
    blt $t3, 10, zero_min_pm
    move $a0, $t3
    syscall
    j pm_label
   
zero_min_pm:
    li $a0, 0
    syscall
    move $a0, $t3
    syscall
   
pm_label:
    li $v0, 4
    la $a0, msg_pm
    syscall
    j time_exit
   
time_am:
    beq $t2, 0, time_midnight
    li $v0, 1
    move $a0, $t2
    syscall
    j am_sep
   
time_midnight:
    li $v0, 1
    li $a0, 12
    syscall
   
am_sep:
    li $v0, 4
    la $a0, msg_colon
    syscall
   
    li $v0, 1
    blt $t3, 10, zero_min_am
    move $a0, $t3
    syscall
    j am_label
   
zero_min_am:
    li $a0, 0
    syscall
    move $a0, $t3
    syscall
   
am_label:
    li $v0, 4
    la $a0, msg_am
    syscall
   
time_exit:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
# ================================================================
# ENHANCED ACADEMIC OVERVIEW
# ================================================================
show_academic_enhanced:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
   
    li $v0, 4
    la $a0, msg_academic_hdr
    syscall
    la $a0, msg_dash
    syscall
   
    la $a0, msg_current
    syscall
    l.s $f12, current_cgpa
    jal print_float
   
    li $v0, 4
    la $a0, msg_credits
    syscall
    li $v0, 1
    lw $a0, completed_credits
    syscall
    li $v0, 4
    la $a0, msg_slash
    syscall
    li $v0, 1
    lw $a0, total_credits
    syscall
   
    li $v0, 4
    la $a0, msg_target
    syscall
    mov.s $f12, $f10
    jal print_float
   
    li $v0, 4
    la $a0, msg_required
    syscall
   
    l.s $f0, current_cgpa
    mov.s $f1, $f10
   
    lw $t0, completed_credits
    lw $t1, remaining_credits
    lw $t2, total_credits
   
    mtc1 $t0, $f2
    cvt.s.w $f2, $f2
    mtc1 $t1, $f3
    cvt.s.w $f3, $f3
    mtc1 $t2, $f4
    cvt.s.w $f4, $f4
   
    mul.s $f5, $f1, $f4
    mul.s $f6, $f0, $f2
    sub.s $f7, $f5, $f6
    div.s $f12, $f7, $f3
   
    jal print_float
   
    l.s $f8, max_sgpa
    c.le.s $f12, $f8
    bc1t achievable
   
    li $v0, 4
    la $a0, msg_impossible
    syscall
   
    l.s $f9, max_sgpa
    mul.s $f10, $f9, $f3
    mul.s $f11, $f0, $f2
    add.s $f12, $f10, $f11
    div.s $f12, $f12, $f4
    jal print_float
   
    li $v0, 4
    la $a0, msg_close_bracket
    syscall
    j academic_done
   
achievable:
    li $v0, 4
    la $a0, msg_achievable
    syscall
   
academic_done:
    li $v0, 4
    la $a0, msg_newline
    syscall
   
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
# ================================================================
# ENHANCED ATTENDANCE
# ================================================================
show_attendance_enhanced:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
   
    li $v0, 4
    la $a0, msg_attendance_hdr
    syscall
    la $a0, msg_dash
    syscall
    la $a0, msg_note
    syscall
   
    li $t0, 0
   
attendance_loop:
    bge $t0, 3, attendance_done
   
    sll $t1, $t0, 2
   
    # Subject name
    la $t2, att_subj_list
    add $t2, $t2, $t1
    lw $a0, 0($t2)
    li $v0, 4
    syscall
   
    li $v0, 4
    la $a0, msg_colon
    syscall
   
    sll $t1, $t0, 2
   
    # Attended/Total
    la $t2, att_attended
    add $t2, $t2, $t1
    lw $t4, 0($t2)
   
    li $v0, 1
    move $a0, $t4
    syscall
   
    li $v0, 4
    la $a0, msg_slash
    syscall
   
    la $t2, att_total
    sll $t1, $t0, 2
    add $t2, $t2, $t1
    lw $t3, 0($t2)
   
    li $v0, 1
    move $a0, $t3
    syscall
   
    # Calculate percentage
    mul $t5, $t4, 100
    div $t5, $t3
    mflo $t6
   
    li $v0, 4
    la $a0, msg_space
    syscall
    la $a0, msg_space
    syscall
   
    li $v0, 1
    move $a0, $t6
    syscall
   
    li $v0, 4
    la $a0, msg_percent
    syscall
   
    li $v0, 4
    la $a0, msg_newline
    syscall
   
attendance_next:
    addi $t0, $t0, 1
    j attendance_loop
   
attendance_done:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
# ================================================================
# ENHANCED SUGGESTIONS
# ================================================================
show_suggestions_enhanced:
    li $v0, 4
    la $a0, msg_suggestions
    syscall
    la $a0, msg_dash
    syscall
    la $a0, msg_morning_study
    syscall
    la $a0, msg_revision
    syscall
    la $a0, msg_library
    syscall
    la $a0, msg_evening_sports
    syscall
    la $a0, msg_assignment
    syscall
    jr $ra
# ================================================================
# MENU
# ================================================================
show_menu:
    li $v0, 4
    la $a0, msg_menu
    syscall
    jr $ra
# ================================================================
# FLOAT PRINTER
# ================================================================
print_float:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
   
    l.s $f0, hundred_const
    mul.s $f1, $f12, $f0
    li.s $f2, 0.5
    add.s $f1, $f1, $f2
   
    cvt.w.s $f3, $f1
    mfc1 $t0, $f3
   
    div $t0, $t0, 100
    mflo $t1
    mfhi $t2
   
    li $v0, 1
    move $a0, $t1
    syscall
   
    li $v0, 11
    li $a0, '.'
    syscall
   
    li $v0, 1
    blt $t2, 10, add_zero_float
    move $a0, $t2
    syscall
    j float_done
   
add_zero_float:
    li $a0, 0
    syscall
    move $a0, $t2
    syscall
   
float_done:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra