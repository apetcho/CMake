#
# Test SET
#
SET (ZERO_VAR 0)
SET (ZERO_VAR2 0)

IF(ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED)
ELSE(ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED)
ENDIF(ZERO_VAR)

SET(ONE_VAR 1)
SET(ONE_VAR2 1)
SET(STRING_VAR "CMake is great" CACHE STRING "test a cache variable")

#
# Test VARIABLE_REQUIRES
#
VARIABLE_REQUIRES(ONE_VAR
                  ONE_VAR_IS_DEFINED ONE_VAR)

#
# Test various IF/ELSE combinations
#
IF(NOT ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_NOT)
ELSE(NOT ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_NOT)
ENDIF(NOT ZERO_VAR)

IF(NOT ONE_VAR)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_NOT2)
ELSE(NOT ONE_VAR)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_NOT2)
ENDIF(NOT ONE_VAR)

IF(ONE_VAR AND ONE_VAR2)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_AND)
ELSE(ONE_VAR AND ONE_VAR2)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_AND)
ENDIF(ONE_VAR AND ONE_VAR2)

IF(ONE_VAR AND ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_AND2)
ELSE(ONE_VAR AND ZERO_VAR)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_AND2)
ENDIF(ONE_VAR AND ZERO_VAR)

IF(ZERO_VAR OR ONE_VAR2)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_OR)
ELSE(ZERO_VAR OR ONE_VAR2)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_OR)
ENDIF(ZERO_VAR OR ONE_VAR2)

IF(ZERO_VAR OR ZERO_VAR2)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_OR2)
ELSE(ZERO_VAR OR ZERO_VAR2)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_OR2)
ENDIF(ZERO_VAR OR ZERO_VAR2)

IF(STRING_VAR MATCHES "^CMake")
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_MATCHES)
ELSE(STRING_VAR MATCHES "^CMake")
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_MATCHES)
ENDIF(STRING_VAR MATCHES "^CMake")

IF(STRING_VAR MATCHES "^foo")
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_MATCHES2)
ELSE(STRING_VAR MATCHES "^foo")
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_MATCHES2)
ENDIF(STRING_VAR MATCHES "^foo")

IF(COMMAND "IF")
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_COMMAND)
ELSE(COMMAND "IF")
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_COMMAND)
ENDIF(COMMAND "IF")

IF(COMMAND "ROQUEFORT")
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_COMMAND2)
ELSE(COMMAND "ROQUEFORT")
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_COMMAND2)
ENDIF(COMMAND "ROQUEFORT")

IF (EXISTS ${Complex_SOURCE_DIR}/VarTests.cmake)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_EXISTS)
ELSE(EXISTS ${Complex_SOURCE_DIR}/VarTests.cmake)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_EXISTS)
ENDIF (EXISTS ${Complex_SOURCE_DIR}/VarTests.cmake)

IF (EXISTS ${Complex_SOURCE_DIR}/roquefort.txt)
  ADD_DEFINITIONS(-DSHOULD_NOT_BE_DEFINED_EXISTS2)
ELSE(EXISTS ${Complex_SOURCE_DIR}/roquefort.txt)
  ADD_DEFINITIONS(-DSHOULD_BE_DEFINED_EXISTS2)
ENDIF (EXISTS ${Complex_SOURCE_DIR}/roquefort.txt)

#
# Test FOREACH
#
FOREACH (INDEX 1 2)
  SET(FOREACH_VAR${INDEX} "VALUE${INDEX}")
ENDFOREACH(INDEX)

SET(FOREACH_CONCAT "")
FOREACH (INDEX "a;b;c;d;e;f;g")
  SET(FOREACH_CONCAT "${FOREACH_CONCAT}${INDEX}")
ENDFOREACH(INDEX)

#
# Test FIND_FILE, FIND_PATH and various GET_FILENAME_COMPONENT combinations
#
FIND_FILE(FILENAME_VAR "VarTests.cmake" ${Complex_SOURCE_DIR})

GET_FILENAME_COMPONENT(FILENAME_VAR_PATH ${FILENAME_VAR} PATH)
GET_FILENAME_COMPONENT(FILENAME_VAR_PATH_NAME ${FILENAME_VAR_PATH} NAME)
GET_FILENAME_COMPONENT(FILENAME_VAR_NAME ${FILENAME_VAR} NAME)
GET_FILENAME_COMPONENT(FILENAME_VAR_EXT ${FILENAME_VAR} EXT)
GET_FILENAME_COMPONENT(FILENAME_VAR_NAME_WE ${FILENAME_VAR} NAME_WE CACHE)

FIND_PATH(PATH_VAR "cmTestConfigure.h.in" ${Complex_SOURCE_DIR})
GET_FILENAME_COMPONENT(PATH_VAR_NAME ${PATH_VAR} NAME)
