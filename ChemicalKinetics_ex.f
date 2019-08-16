      PROGRAM ChemicalKinetics_ex
C
C*****DOUBLE PRECISION
      IMPLICIT DOUBLE PRECISION (A-H, O-Z), INTEGER (I-N)
C*****END DOUBLE PRECISION
C*****SINGLE PRECISION
C      IMPLICIT REAL (A-H, O-Z), INTEGER (I-N)
C*****END SINGLE PRECISION
      PARAMETER ( LENIWK = 35000, LENRWK = 250000, LENCWK = 1000,
     1            LENSYM = 16)
      DIMENSION ICKWRK (LENIWK), RCKWRK (LENRWK)
      REAL(8), ALLOCATABLE, DIMENSION(:) :: X
      REAL(8), ALLOCATABLE, DIMENSION(:) :: Y
      REAL(8), ALLOCATABLE, DIMENSION(:) :: HMS
      REAL(8), ALLOCATABLE, DIMENSION(:) :: WTM
      REAL(8), ALLOCATABLE, DIMENSION(:) :: WDOT
      CHARACTER CWORK(LENCWK)*(LENSYM)
      DATA LIN/5/, LOUT/6/, LINKCK/25/, LTMN/9/

C*****unix
      OPEN (LINKCK, FORM='UNFORMATTED', FILE='input/cklink')
      OPEN (LIN, FORM='FORMATTED', FILE='input/datasheet')
      OPEN (LTMN, FORM='FORMATTED', FILE='output/terminal_out')
      OPEN (LOUT, FORM='FORMATTED', FILE='output/ckex_out')
C*****END unix


      ! INITIALIZE WORK ARRAY BY inp FILE
      CALL CKINIT(LENIWK, LENRWK, LENCWK, LINKCK, LTMN,
     1            ICKWRK, RCKWRK, CWORK)
      CALL CKINDX(ICKWRK, RCKWRK, MM, KK, II, NFIT)
      ALLOCATE (X(KK), Y(KK), HMS(KK), WTM(KK), WDOT(KK))

      ! READ EACH ROW IN DATASHEET

      READ (LIN, *) COL_TIME, P, T, (X(I), I = 1, KK)
      WRITE (LOUT, *) COL_TIME, P, T, (X(I), I = 1, KK)

      ! Set parameters of explicit calculation
      DELT_TIME = 1d-15
      END_TIME  = 1d-14
      P_DYNE    = P * 1.01325d6
C
C     START TIME INTEGRATION LOOP
C
      DO WHILE (COL_TIME .LE. END_TIME)
          COL_TIME = COL_TIME + DELT_TIME

          ! CALCULATE REQUIRED PARAMETERS
          CALL CKXTY  (X, ICKWRK, RCKWRK, Y)
          CALL CKRHOY (P_DYNE, T, Y, ICKWRK, RCKWRK, RHO)
          CALL CKHMS  (T, ICKWRK, RCKWRK, HMS)
          CALL CKCPBS (T, Y, ICKWRK, RCKWRK, CPBMS)
          CALL CKMMWY (Y, ICKWRK, RCKWRK, WTM)
          CALL CKWYP  (P_DYNE, T, Y, ICKWRK, RCKWRK, WDOT)

          ! UPDATE TEMPERATURE
          TEMP = 0
          DO K = 1, KK
              TEMP = TEMP + HMS(K)*WDOT(K)*WTM(K)
          END DO
          T = T - DELT_TIME/RHO/CPBMS*TEMP

          ! UPDATE MASS FRACTION
          DO K = 1, KK
              Y(K) = Y(K) + DELT_TIME/RHO*WDOT(K)*WTM(K)
          END DO

          ! PRINT OUT RESULT
          P = P_DYNE / 1.01325d6
          CALL CKYTX  (Y, ICKWRK, RCKWRK, X)
          WRITE (LOUT, *) COL_TIME, P, T, (X(I), I = 1, KK)    

      END DO
C
      END PROGRAM