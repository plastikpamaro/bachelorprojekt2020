#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux
CND_DLIB_EXT=so
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/_ext/cb3946f3/bangDetector.o \
	${OBJECTDIR}/_ext/cb3946f3/cameraControl.o \
	${OBJECTDIR}/_ext/cb3946f3/doaAlgorithm.o \
	${OBJECTDIR}/_ext/cb3946f3/doaV2.o \
	${OBJECTDIR}/_ext/cb3946f3/fft.o \
	${OBJECTDIR}/_ext/cb3946f3/input_pipe.o \
	${OBJECTDIR}/_ext/cb3946f3/main.o \
	${OBJECTDIR}/_ext/cb3946f3/utils.o \
	${OBJECTDIR}/_ext/cb3946f3/xcorr.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-I/usr/local/include -lraspicam -lbcm2835

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/blitzer

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/blitzer: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/blitzer ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/_ext/cb3946f3/bangDetector.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/bangDetector.cpp
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/bangDetector.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/bangDetector.cpp

${OBJECTDIR}/_ext/cb3946f3/cameraControl.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/cameraControl.cpp
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/cameraControl.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/cameraControl.cpp

${OBJECTDIR}/_ext/cb3946f3/doaAlgorithm.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/doaAlgorithm.c
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/doaAlgorithm.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/doaAlgorithm.c

${OBJECTDIR}/_ext/cb3946f3/doaV2.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/doaV2.cpp
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/doaV2.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/doaV2.cpp

${OBJECTDIR}/_ext/cb3946f3/fft.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/fft.c
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/fft.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/fft.c

${OBJECTDIR}/_ext/cb3946f3/input_pipe.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/input_pipe.c
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/input_pipe.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/input_pipe.c

${OBJECTDIR}/_ext/cb3946f3/main.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/main.cpp
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/main.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/main.cpp

${OBJECTDIR}/_ext/cb3946f3/utils.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/utils.c
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/utils.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/utils.c

${OBJECTDIR}/_ext/cb3946f3/xcorr.o: ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/xcorr.c
	${MKDIR} -p ${OBJECTDIR}/_ext/cb3946f3
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/cb3946f3/xcorr.o ../../../OneDrive\ -\ haw-hamburg.de/SharebasePc/BachelorProjekt/Studienarbeit19_2/Studienarbeit/Entwicklung/Lauscher/xcorr.c

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
