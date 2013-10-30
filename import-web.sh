#!/bin/sh
# mheck, 20130404
# Uses registrar provided data directly
######
###### NOTE!!!
######
# Need to update "term_in=######" with new semester terms:
#   yyyym0
#   yyyy = year
#   m = month of start of semester:
#	1 = Spring Semester
#	5 = Summer One
#	6 = Summer Two
#	8 = Fall Semester
######
######
######
curl -d 'term_in=201410&sel_subj=dummy&sel_day=dummy&sel_schd=dummy&sel_insm=dummy&sel_camp=dummy&sel_levl=dummy&sel_sess=dummy&sel_instr=dummy&sel_ptrm=dummy&sel_attr=dummy&sel_subj=&sel_crse=&sel_title=&sel_schd=%25&sel_from_cred=&sel_to_cred=&sel_levl=%25&sel_ptrm=%25&sel_instr=%25&begin_hh=0&begin_mi=0&begin_ap=a&end_hh=0&end_mi=0&end_ap=a' https://banner.mines.edu/prod/owa/bwckschd.p_get_crse_unsec > /tmp/courses
