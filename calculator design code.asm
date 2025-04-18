.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'For Addition operation   :'1'$'
MSG2 DB 10,13,'For Subtraction operation    :'2'$'
MSG3 DB 10,13,'For Multiplication operation   :'3'$'
MSG4 DB 10,13,'For Division operation    :'4'$'
MSG5 DB 10,13,'Choose Any One:$'
MSG6 DB 10,13,10,13,'Enter 1st Number:$'
MSG7 DB 10,13,'Enter 2nd Number:$'
MSG8 DB 10,13,'The Result is:$' 
MSG9 DB 10,13,10,13,'Error: Division by zero not possible ', '$'
MSG DB 10,13,10,13,'               **THANK YOU FOR USING THIS CALCULATOR$'
MSG10 DB 10,13,'Invalid Input,PLEASE choose between (1-4)$'                           

NUM1 DB 0
NUM2 DB 0
RESULT DB 0  


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    LEA DX,MSG4
    MOV AH,9
    INT 21H 
    
    
    
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
  
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48
    
    CMP BH,1
    JE ADD
    
    CMP BH,2
    JE SUB
     
    CMP BH,3
    JE MUL
    
    CMP BH,4
    JE DIV
     
    
     Default:
     
    LEA DX,MSG10  
    MOV AH,9
    INT 21H
     JMP EXIT_P 
    
    
  ADD:
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    MOV AH,1
    INT 21H
    MOV CL,AL
    
    ADD AL,BL
    MOV AH,0
    AAA
    
    
    MOV BX,AX 
    ADD BH,48
    ADD BL,48 
    
 
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    JMP EXIT_P 
    
 
     
    
   SUB:
 
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    MOV AH,1
    INT 21H
    MOV CL,AL
    
    SUB BL,CL
    ADD BL,48
    
    
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H
    
    
    
    JMP EXIT_P 
    
    
    
    
   MUL:
 
    LEA DX,MSG6
    MOV AH,9
    INT 21H
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
    
    
    LEA DX,MSG7
    MOV AH,9
    INT 21H 
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL
    
    
    MUL NUM1
    MOV RESULT,AL
    AAM  
    
    
    ADD AH,30H
    ADD AL,30H
    
    
    MOV BX,AX 
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    
    
    JMP EXIT_P  
    
   
   
   
   
 DIV:
    LEA DX,MSG6
    MOV AH,9
    INT 21H
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
    
    
    LEA DX,MSG7
    MOV AH,9
    INT 21H 
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL 
    
    STI
    
    CMP NUM2,0
    JE DivisionByZeroErrorHandler 
    
    MOV CL,NUM1
    MOV CH,00
    MOV AX,CX 
    
    
    DIV NUM2
    MOV RESULT,AL
    MOV AH, 00
    AAD  
    
    
    ADD AH,30H
    ADD AL,30H
    
    
    MOV BX,AX 
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    
    
    JMP EXIT_P  
    
     DivisionByZeroErrorHandler:  
     
    MOV AX, 00H
    MOV SS, AX
    MOV SI,0000H
    MOV AX, 60h
    MOV BX,4H
    MUL BX
    MOV BX,AX
    MOV SI, OFFSET [MY_DIV_BY_ZERO_ISR]
    MOV SS:[BX],SI
    ADD BX,2
    MOV SS:[BX],cs    
    
    INT 60H
    
    JMP EXIT_P
    
    EXIT_P:
    
        LEA DX,MSG
        MOV AH,9
        INT 21H  
  
    
   
         
        
    EXIT:
    
    MOV AH,4CH
    INT 21H  
    
    
  
    
    MAIN ENDP  
    
MY_DIV_BY_ZERO_ISR PROC 
 
    MOV AH, 09h
   mov DX, offset MSG9 
    INT 21h

   JMP EXIT_P
    
    RETF 
MY_DIV_BY_ZERO_ISR ENDP



END MAIN
