param n;
set rows:= 1..n;
set columns:= 1..n;
set box:=1..3;
set box_combin = {i1 in box, i2 in box: i1 <> i2};
set box_combin1 = {i1 in box, i2 in box};
set box_combin2 = {i1 in box, i2 in box,i3 in box, i4 in box: i1<>i3 or i2<>i4};
#set box_combin2 = {x in box_combin1, y in box_combin1};
#set combin = {rows,columns};
set combin = {i1 in rows, i2 in rows: i1 <> i2};

var val{rows,columns} >=1,<=9 integer ;

s.t.
#row_sum{i in rows}:sum {j in columns} val[i,j]=((n*(n+1))/2);
#col_sum{j in columns}:sum {i in rows} val[i,j]=((n*(n+1))/2);
#box_sum{k in {0,3,6},p in {0,3,6}}: sum {i in {1,2,3}, j in {1,2,3}} val[i+k,j+p]= ((n*(n+1))/2);

unique_col{j in columns}:forall {(i,k) in combin} val[i,j]<>val[k,j];
unique_row{i in rows}:forall {(j,k) in combin} val[i,j]<>val[i,k];
unique_box {k in {1,4,7},p in {1,4,7}}: alldiff {i in k..k+2, j in p..p+2} val[i,j];
#top_left: sum {i in {1,2,3}, j in {1,2,3}} val[i,j]= ((n*(n+1))/2);
#top_mid: sum {i in {1,2,3}, j in {4,5,6}} val[i,j]= ((n*(n+1))/2);
#top_right: sum {i in {1,2,3}, j in {7,8,9}} val[i,j]= ((n*(n+1))/2);

#mid_left: sum {i in {4,5,6}, j in {1,2,3}} val[i,j]= ((n*(n+1))/2);
#mid_mid: sum {i in {4,5,6}, j in {4,5,6}} val[i,j]= ((n*(n+1))/2);
#mid_right: sum {i in {4,5,6}, j in {7,8,9}} val[i,j]= ((n*(n+1))/2);

#bottom_left: sum {i in {7,8,9}, j in {1,2,3}} val[i,j]= ((n*(n+1))/2);
#bottom_mid: sum {i in {7,8,9}, j in {4,5,6}} val[i,j]= ((n*(n+1))/2);
#bottom_right: sum {i in {7,8,9}, j in {7,8,9}} val[i,j]= ((n*(n+1))/2);


#unique_box_1{(i,j,m,n) in box_combin2}:val[i,j]<>val[m,n];
#unique_box_2{k in {0},p in {0}}:forall {(i,j,m,n) in box_combin2} val[i+k,j+p]<>val[m+k,n+p];
#: i<>m or j<>n 

#r: val[1,1]<>val[1,2];
given1:val[1,5]=8;
given2:val[1,7]=6;
given3:val[1,8]=5;

given4:val[2,2]=3;

given5:val[3,1]=7;
given6:val[3,3]=8;
given7:val[3,4]=3;
given8:val[3,7]=4;

given9:val[4,1]=2;
given10:val[4,4]=7;
given11:val[4,7]=8;

given12:val[5,1]=1;
given13:val[5,4]=6;
given14:val[5,6]=4;
given15:val[5,9]=9;

given16:val[6,3]=7;
given17:val[6,6]=1;
given18:val[6,9]=4;

given19:val[7,3]=6;
given20:val[7,6]=8;
given21:val[7,7]=5;
given22:val[7,9]=7;

given23:val[8,8]=8;

given24:val[9,2]=7;
given25:val[9,3]=1;
given26:val[9,5]=9;


#param given {1..9, 1..9} integer, in 0..9;
  # given[i,j] > 0 is the value given for row i, col j
  # given[i,j] = 0 means no value given 
#var X {1..9, 1..9} integer, in 1..9;
  # x[i,j] = the number assigned to the cell in row i, col j
#subj to AssignGiven {i in 1..9, j in 1..9: given[i,j] > 0}: X[i,j]= given[i,j];
  # assign given values
#subj to Rows {i in 1..9}: alldiff {j in 1..9} X[i,j];
  # cells in the same row must be assigned distinct numbers
#subj to Cols {j in 1..9}: alldiff {i in 1..9} X[i,j];
  # cells in the same column must be assigned distinct numbers
#subj to Regions {I in 1..9 by 3, J in 1..9 by 3}: alldiff {i in I..I+2, j in J..J+2} val[i,j];
#subj to unique_box {k in {1,4,7},p in {1,4,7}}: alldiff {i in k..k+2, j in p..p+2} val[i,j];
  # cells in the same region must be assigned distinct numbers

