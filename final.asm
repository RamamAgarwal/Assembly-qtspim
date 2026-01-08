# ================================================================
# OP-CODE: Campus Buddy v2.0 - Personalized Life Manager
# ================================================================

.data
# ===== STUDENT PROFILE =====
student_id:         .asciiz "2023A7PS0123U"
student_name:       .asciiz "Ramam Agarwal"
program:            .asciiz "B.E. Computer Science"
current_cgpa:       .float 8.68
completed_credits:  .word 78
total_credits:      .word 174
current_semester:   .word 5
current_time:       .word 1030        # 10:30 AM

# Personalization (derived from ID)
schedule_pattern:   .word 3           # ID % 8 = 3
learning_style:     .word 2           # (ID>>2) % 4 = 2
focus_duration:     .word 1           # Sum % 5 = 1
productivity_idx:   .word 23          # ID % 100 = 23

# Input
day_input:          .space 20

# Monday Schedule
mon_times:          .word 900, 1200, 1400
mon_durations:      .word 90, 60, 90
mon_subj_list:      .word dl, toc, fcs
mon_room_list:      .word r2201, r2202, r2201
mon_count:          .word 3

# Tuesday
tue_times:          .word 1400
tue_durations:      .word 90
tue_subj_list:      .word smia
tue_room_list:      .word r1001b
tue_count:          .word 1

# Wednesday
wed_times:          .word 900, 1200, 1400
wed_durations:      .word 90, 60, 90
wed_count:          .word 3

# Thursday
thu_times:          .word 1400
thu_durations:      .word 90
thu_count:          .word 1

# Friday
fri_times:          .word 1100, 1200, 1600
fri_durations:      .word 60, 60, 60
fri_subj_list:      .word smiat, toc2, toct
fri_room_list:      .word r2201, r2202, r2201
fri_count:          .word 3

# Attendance Data (with marks system)
att_subj_list:      .word dl, toc, fcs
att_attended:       .word 17, 34, 23
att_total:          .word 19, 36, 24
att_remaining:      .word 5, 4, 5
att_count:          .word 3

# Course Strings
dl:                 .asciiz "Deep Learning"
toc:                .asciiz "Theory of Computation"
fcs:                .asciiz "Foundations of Computer Systems"
smia:               .asciiz "Search Methods in AI"
smiat:              .asciiz "SMIA Tutorial"
toc2:               .asciiz "Theory of Computation"
toct:               .asciiz "TOC Tutorial"
r2201:              .asciiz "Room 2201"
r2202:              .asciiz "Room 2202"
r1001b:             .asciiz "Room 1001(B)"

# Location suggestions
loc_library:        .asciiz "Library (Ground Floor)"
loc_cafeteria:      .asciiz "Cafeteria"
loc_study_room:     .asciiz "Study Room 3105"
loc_hostel:         .asciiz "Hostel Common Room"
loc_lab:            .asciiz "Computer Lab"
loc_lounge:         .asciiz "Student Activity Center"

# UI STRINGS
msg_banner:         .asciiz "\n========================================\n   CAMPUS BUDDY v2.0\n   Your Personalized Life Manager\n========================================\n"
msg_profile_hdr:    .asciiz "[STUDENT PROFILE]\n"
msg_student_id:     .asciiz "Student ID: "
msg_name:           .asciiz "\nName: "
msg_program:        .asciiz "\nProgram: "
msg_current_day:    .asciiz "\nCurrent Day: "

msg_person_hdr:     .asciiz "\n\n[PERSONALIZATION PROFILE]\n"
msg_schedule_pat:   .asciiz "Schedule Pattern (ID % 8): "
msg_learning:       .asciiz "\nLearning Style ((ID>>2) % 4): "
msg_focus:          .asciiz "\nFocus Duration (Sum % 5): "
msg_productivity:   .asciiz "\nProductivity Index (ID % 100): "
msg_profile_type:   .asciiz "\n\nBased on your profile, you are:\n>> "

msg_schedule_hdr:   .asciiz "\n\n[TODAY'S SCHEDULE - "
msg_schedule_close: .asciiz "]\n-----------------------------------\n"
msg_curr_time:      .asciiz "Current Time: "
msg_next_class:     .asciiz "\n>> NEXT CLASS: "
msg_time_until:     .asciiz "\nTime until next class: "
msg_minutes:        .asciiz " minutes"
msg_separator:      .asciiz "\n-----------------------------------\n"

msg_completed:      .asciiz "[COMPLETED] "
msg_free:           .asciiz "[FREE] "
msg_upcoming:       .asciiz "[UPCOMING] "
msg_location:       .asciiz "\n   Location: "
msg_suggestion:     .asciiz "\n   >> Suggestion: "
msg_best_loc:       .asciiz "\n   >> Best Location: "

msg_academic_hdr:   .asciiz "\n\n[ACADEMIC OVERVIEW]\n"
msg_current_cgpa:   .asciiz "Current CGPA: "
msg_target_cgpa:    .asciiz "\nTarget CGPA: "
msg_credits:        .asciiz "\nCredits Completed: "
msg_progress:       .asciiz "\nDegree Progress: "
msg_required_sgpa:  .asciiz "\nRequired SGPA this semester: "
msg_feedback:       .asciiz "\n>> "

msg_attend_hdr:     .asciiz "\n\n[ATTENDANCE PLANNER]\n"
msg_current_att:    .asciiz "   Current: "
msg_classes:        .asciiz " classes ("
msg_status:         .asciiz "   Status: "
msg_marks:          .asciiz " marks"
msg_max_achieve:    .asciiz "   Maximum Achievable: "
msg_max_marks:      .asciiz "   Max Marks: "
msg_critical:       .asciiz "   CRITICAL - Need to improve attendance!"
msg_warning:        .asciiz "   WARNING - Close to minimum threshold!"
msg_good:           .asciiz "   GOOD - Maintain this level!"
msg_excellent:      .asciiz "   EXCELLENT - Well above requirements!"

msg_recommend_hdr:  .asciiz "\n\n[SMART RECOMMENDATIONS]\n"
msg_based_on:       .asciiz "Based on your schedule and productivity profile:\n"

msg_menu_hdr:       .asciiz "\n\n[MENU OPTIONS]\n"
msg_menu:           .asciiz "1-Schedule | 2-Grades | 3-Attendance | 4-Suggestions | 5-Exit\n"

msg_time_sep:       .asciiz "-"
msg_slash:          .asciiz "/"
msg_colon:          .asciiz ":"
msg_percent:        .asciiz "%"
msg_paren_open:     .asciiz " ("
msg_paren_close:    .asciiz ")"
msg_newline:        .asciiz "\n"
msg_space:          .asciiz " "
msg_am:             .asciiz " AM"
msg_pm:             .asciiz " PM"

# Profile descriptions
profile_balanced:   .asciiz "Balanced learner with steady 1-2hr focus sessions"
profile_intensive:  .asciiz "Intensive learner preferring 3-4hr deep work blocks"
profile_short:      .asciiz "Quick learner with frequent 30-45min sessions"
profile_flexible:   .asciiz "Flexible learner adapting to varying schedules"

# Activity suggestions
sug_study_short:    .asciiz "Quick review session (20-30 mins)"
sug_study_long:     .asciiz "Extended study session (1-2 hours)"
sug_meal:           .asciiz "Meal break & social time"
sug_workout:        .asciiz "Workout or sports activity"
sug_project:        .asciiz "Work on course project or assignment"
sug_revision:       .asciiz "Revision of recent topics"
sug_relax:          .asciiz "Short relaxation break"

# Constants
hundred_const:      .float 100.0
max_sgpa:           .float 10.0
seventy_five:       .float 75.0

# Input prompt
prompt_cgpa:        .asciiz "\nEnter target CGPA (for end of 8 semesters): "
prompt_day:         .asciiz "Enter day (Monday/Tuesday/Wednesday/Thursday/Friday): "

.text
.globl main

# ================================================================
# MAIN PROGRAM
# ================================================================
main:
    # Get target CGPA
    li $v0, 4
    la $a0, prompt_cgpa
    syscall
    
    li $v0, 6
    syscall
    mov.s $f10, $f0
    
    # Get day
    li $v0, 4
    la $a0, prompt_day
    syscall
    
    li $v0, 8
    la $a0, day_input
    li $a1, 20
    syscall
    
    jal clean_input
    jal show_banner
    jal show_profile
    jal show_personalization
    jal show_schedule_contextual
    jal show_academic_detailed
    jal show_attendance_detailed
    jal show_recommendations
    jal show_menu
    
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
# BANNER
# ================================================================
show_banner:
    li $v0, 4
    la $a0, msg_banner
    syscall
    jr $ra

# ================================================================
# STUDENT PROFILE
# ================================================================
show_profile:
    li $v0, 4
    la $a0, msg_profile_hdr
    syscall
    
    la $a0, msg_student_id
    syscall
    la $a0, student_id
    syscall
    
    la $a0, msg_name
    syscall
    la $a0, student_name
    syscall
    
    la $a0, msg_program
    syscall
    la $a0, program
    syscall
    
    la $a0, msg_current_day
    syscall
    la $a0, day_input
    syscall
    
    jr $ra

# ================================================================
# PERSONALIZATION PROFILE
# ================================================================
show_personalization:
    li $v0, 4
    la $a0, msg_person_hdr
    syscall
    
    la $a0, msg_schedule_pat
    syscall
    li $v0, 1
    lw $a0, schedule_pattern
    syscall
    
    li $v0, 4
    la $a0, msg_learning
    syscall
    li $v0, 1
    lw $a0, learning_style
    syscall
    
    li $v0, 4
    la $a0, msg_focus
    syscall
    li $v0, 1
    lw $a0, focus_duration
    syscall
    
    li $v0, 4
    la $a0, msg_productivity
    syscall
    li $v0, 1
    lw $a0, productivity_idx
    syscall
    
    # Show profile description
    li $v0, 4
    la $a0, msg_profile_type
    syscall
    
    lw $t0, focus_duration
    beq $t0, 0, show_short_profile
    beq $t0, 1, show_balanced_profile
    beq $t0, 2, show_intensive_profile
    la $a0, profile_flexible
    j print_profile
    
show_short_profile:
    la $a0, profile_short
    j print_profile
    
show_balanced_profile:
    la $a0, profile_balanced
    j print_profile
    
show_intensive_profile:
    la $a0, profile_intensive
    
print_profile:
    syscall
    
    jr $ra

# ================================================================
# CONTEXTUAL SCHEDULE (with status markers)
# ================================================================
show_schedule_contextual:
    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)
    
    # Print header
    li $v0, 4
    la $a0, msg_schedule_hdr
    syscall
    la $a0, day_input
    syscall
    la $a0, msg_schedule_close
    syscall
    
    # Current time
    la $a0, msg_curr_time
    syscall
    lw $a0, current_time
    jal print_time
    
    # Determine day schedule
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
    j thursday

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
    j find_next_class

tuesday:
    li $s0, 1
    la $s1, tue_times
    la $s2, tue_durations
    la $s3, tue_subj_list
    la $s4, tue_room_list
    j find_next_class

wednesday:
    li $s0, 3
    la $s1, wed_times
    la $s2, wed_durations
    la $s3, mon_subj_list
    la $s4, mon_room_list
    j find_next_class

thursday:
    li $s0, 1
    la $s1, thu_times
    la $s2, thu_durations
    la $s3, tue_subj_list
    la $s4, tue_room_list
    j find_next_class

friday:
    li $s0, 3
    la $s1, fri_times
    la $s2, fri_durations
    la $s3, fri_subj_list
    la $s4, fri_room_list
    j find_next_class

find_next_class:
    li $t5, 0
    li $s6, -1              # Next class index
    lw $t9, current_time
    
find_loop:
    bge $t5, $s0, show_next_class
    sll $t6, $t5, 2
    add $t7, $s1, $t6
    lw $t8, 0($t7)
    
    ble $t8, $t9, skip_next
    beq $s6, -1, set_next
    j skip_next
    
set_next:
    move $s6, $t5
    
skip_next:
    addi $t5, $t5, 1
    j find_loop

show_next_class:
    beq $s6, -1, no_more_classes
    
    li $v0, 4
    la $a0, msg_next_class
    syscall
    
    sll $t6, $s6, 2
    add $t7, $s3, $t6
    lw $t7, 0($t7)
    move $a0, $t7
    syscall
    
    # Calculate time until
    la $a0, msg_time_until
    syscall
    
    sll $t6, $s6, 2
    add $t7, $s1, $t6
    lw $t8, 0($t7)
    lw $t9, current_time
    
    # Convert to minutes
    div $t8, $t8, 100
    mflo $t0
    mfhi $t1
    mul $t0, $t0, 60
    add $t0, $t0, $t1
    
    div $t9, $t9, 100
    mflo $t2
    mfhi $t3
    mul $t2, $t2, 60
    add $t2, $t2, $t3
    
    sub $t4, $t0, $t2
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    li $v0, 4
    la $a0, msg_minutes
    syscall
    
    la $a0, msg_separator
    syscall
    j print_schedule

no_more_classes:
    li $v0, 4
    la $a0, msg_separator
    syscall

print_schedule:
    li $t5, 0
    li $s5, 0
    
schedule_loop:
    bge $t5, $s0, schedule_end
    
    # Determine status
    sll $t6, $t5, 2
    add $t7, $s1, $t6
    lw $t8, 0($t7)
    lw $t9, current_time
    
    # Calculate end time
    add $t7, $s2, $t6
    lw $a1, 0($t7)
    div $t8, $t8, 100
    mflo $t0
    mfhi $t1
    mul $t0, $t0, 60
    add $t0, $t0, $t1
    add $t0, $t0, $a1
    div $t0, $t0, 60
    mflo $t1
    mfhi $t2
    mul $t1, $t1, 100
    add $t3, $t1, $t2     # End time
    
    blt $t3, $t9, print_completed
    bgt $t8, $t9, print_upcoming
    
    # Currently in class
    j print_upcoming

print_completed:
    li $v0, 4
    la $a0, msg_newline
    syscall
    la $a0, msg_completed
    syscall
    j print_class_time

print_upcoming:
    # Check if there's free time before this
    beqz $t5, skip_free_time
    ble $s5, $t8, skip_free_time
    
    # Print free slot
    li $v0, 4
    la $a0, msg_newline
    syscall
    la $a0, msg_free
    syscall
    
    move $a0, $s5
    jal print_time
    
    li $v0, 4
    la $a0, msg_time_sep
    syscall
    
    move $a0, $t8
    jal print_time
    
    # Calculate duration
    div $s5, $s5, 100
    mflo $t0
    mfhi $t1
    mul $t0, $t0, 60
    add $t0, $t0, $t1
    
    div $t8, $t8, 100
    mflo $t2
    mfhi $t3
    mul $t2, $t2, 60
    add $t2, $t2, $t3
    
    sub $t4, $t2, $t0
    
    li $v0, 4
    la $a0, msg_paren_open
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    li $v0, 4
    la $a0, msg_minutes
    syscall
    la $a0, msg_paren_close
    syscall
    
    # Suggest activity
    jal suggest_activity
    
skip_free_time:
    li $v0, 4
    la $a0, msg_newline
    syscall
    la $a0, msg_upcoming
    syscall

print_class_time:
    sll $t6, $t5, 2
    add $t7, $s1, $t6
    lw $a0, 0($t7)
    jal print_time
    
    li $v0, 4
    la $a0, msg_time_sep
    syscall
    
    # End time (already calculated in $t3)
    move $a0, $t3
    jal print_time
    
    li $v0, 4
    la $a0, msg_space
    syscall
    la $a0, msg_time_sep
    syscall
    la $a0, msg_space
    syscall
    
    # Subject
    sll $t6, $t5, 2
    add $t7, $s3, $t6
    lw $t7, 0($t7)
    move $a0, $t7
    syscall
    
    # Location
    la $a0, msg_location
    syscall
    
    sll $t6, $t5, 2
    add $t7, $s4, $t6
    lw $t7, 0($t7)
    move $a0, $t7
    syscall
    
    # Update previous end time
    move $s5, $t3
    
    addi $t5, $t5, 1
    j schedule_loop

schedule_end:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    lw $s6, 28($sp)
    addi $sp, $sp, 32
    jr $ra

# ================================================================
# ACTIVITY SUGGESTION
# ================================================================
suggest_activity:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $v0, 4
    la $a0, msg_suggestion
    syscall
    
    # Suggest based on duration in $t4
    blt $t4, 45, suggest_short
    blt $t4, 90, suggest_medium
    la $a0, sug_study_long
    j print_sug
    
suggest_short:
    la $a0, sug_relax
    j print_sug
    
suggest_medium:
    la $a0, sug_revision
    
print_sug:
    syscall
    
    # Suggest location
    li $v0, 4
    la $a0, msg_best_loc
    syscall
    
    blt $t4, 60, loc_cafe
    blt $t4, 120, loc_lib
    la $a0, loc_study_room
    j print_loc
    
loc_cafe:
    la $a0, loc_cafeteria
    j print_loc
    
loc_lib:
    la $a0, loc_library
    
print_loc:
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
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
# DETAILED ACADEMIC OVERVIEW
# ================================================================
show_academic_detailed:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $v0, 4
    la $a0, msg_academic_hdr
    syscall
    
    la $a0, msg_current_cgpa
    syscall
    l.s $f12, current_cgpa
    jal print_float
    
    li $v0, 4
    la $a0, msg_target_cgpa
    syscall
    mov.s $f12, $f10
    jal print_float
    
    li $v0, 4
    la $a0, msg_credits
    syscall
    li $v0, 1
    lw $a0, completed_credits
    syscall
    li $v0, 4
    la $a0, msg_space
    syscall
    la $a0, msg_slash
    syscall
    la $a0, msg_space
    syscall
    li $v0, 1
    lw $a0, total_credits
    syscall
    
    # Calculate progress percentage
    li $v0, 4
    la $a0, msg_progress
    syscall
    
    lw $t0, completed_credits
    lw $t1, total_credits
    mul $t2, $t0, 100
    div $t2, $t1
    mflo $t3
    
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, msg_percent
    syscall
    
    # Required SGPA
    li $v0, 4
    la $a0, msg_required_sgpa
    syscall
    
    l.s $f0, current_cgpa
    mov.s $f1, $f10
    
    lw $t0, completed_credits
    li $t1, 96                  # Remaining
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
    
    # Feedback
    li $v0, 4
    la $a0, msg_feedback
    syscall
    
    l.s $f8, max_sgpa
    c.le.s $f12, $f8
    bc1f impossible_target
    
    # Check if challenging
    li.s $f9, 9.0
    c.lt.s $f9, $f12
    bc1t challenging
    
    # Achievable
    la $a0, sug_revision
    syscall
    j academic_end
    
challenging:
    li $v0, 4
    la $a0, msg_newline
    syscall
    li $v0, 4
    la $a0, msg_feedback
    syscall
    li $v0, 4
    la $a0, profile_intensive
    syscall
    j academic_end
    
impossible_target:
    li $v0, 4
    la $a0, msg_critical
    syscall
    
academic_end:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# DETAILED ATTENDANCE
# ================================================================
show_attendance_detailed:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $v0, 4
    la $a0, msg_attend_hdr
    syscall
    
    li $t0, 0
    
att_loop:
    bge $t0, 3, att_end
    
    li $v0, 4
    la $a0, msg_newline
    syscall
    
    # Subject name
    sll $t1, $t0, 2
    la $t2, att_subj_list
    add $t2, $t2, $t1
    lw $a0, 0($t2)
    syscall
    la $a0, msg_colon
    syscall
    la $a0, msg_newline
    syscall
    
    # Current attendance
    la $a0, msg_current_att
    syscall
    
    sll $t1, $t0, 2
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
    
    # Percentage
    li $v0, 4
    la $a0, msg_classes
    syscall
    
    mul $t5, $t4, 100
    div $t5, $t3
    mflo $t6
    
    li $v0, 1
    move $a0, $t6
    syscall
    
    li $v0, 4
    la $a0, msg_percent
    syscall
    la $a0, msg_paren_close
    syscall
    la $a0, msg_newline
    syscall
    
    # Status based on percentage
    la $a0, msg_status
    syscall
    
    blt $t6, 65, status_critical
    blt $t6, 75, status_warning
    blt $t6, 85, status_good
    
    li $v0, 4
    la $a0, msg_excellent
    syscall
    j att_next
    
status_critical:
    li $v0, 4
    la $a0, msg_critical
    syscall
    j att_next
    
status_warning:
    li $v0, 4
    la $a0, msg_warning
    syscall
    j att_next
    
status_good:
    li $v0, 4
    la $a0, msg_good
    syscall
    
att_next:
    li $v0, 4
    la $a0, msg_newline
    syscall
    
    addi $t0, $t0, 1
    j att_loop
    
att_end:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ================================================================
# RECOMMENDATIONS
# ================================================================
show_recommendations:
    li $v0, 4
    la $a0, msg_recommend_hdr
    syscall
    la $a0, msg_based_on
    syscall
    
    # Give 3-4 recommendations
    la $a0, msg_space
    syscall
    la $a0, msg_space
    syscall
    la $a0, sug_study_long
    syscall
    la $a0, msg_newline
    syscall
    
    la $a0, msg_space
    syscall
    la $a0, msg_space
    syscall
    la $a0, sug_project
    syscall
    la $a0, msg_newline
    syscall
    
    la $a0, msg_space
    syscall
    la $a0, msg_space
    syscall
    la $a0, sug_workout
    syscall
    la $a0, msg_newline
    syscall
    
    jr $ra

# ================================================================
# MENU
# ================================================================
show_menu:
    li $v0, 4
    la $a0, msg_menu_hdr
    syscall
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