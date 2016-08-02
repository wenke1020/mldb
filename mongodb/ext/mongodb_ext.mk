# mongodb_ext.mk
# Jeremy Barnes, 23 February 2015
# Copyright (c) 2015 Datacratic Inc.  All rights reserved

ifneq ($(PREMAKE),1)

LIBBSON:=$(CWD)/mongo-c-driver/src/libbson
###############################################################################
# First, the BSON C library
BSON_SRC_FILES:=$(shell find $(LIBBSON)/src -name "*.c")
BSON_SRC_BUILD:=$(BSON_SRC_FILES:$(CWD)/%=%)
$(BSON_SRC_FILES): $(LIBBSON)/src/bson/bson-config.h

# Rather than run automake and autoconf, etc we simply copy the file in
$(LIBBSON)/src/bson/bson-config.h: $(CWD)/bson-config.h
	@cp $< $@~ && mv $@~ $@

$(eval $(call set_compile_option,$(BSON_SRC_BUILD),-I$(LIBBSON)/src/bson -I$(LIBBSON)/src -I$(LIBBSON)/build/cmake/bson -DBSON_COMPILATION -Wno-maybe-uninitialized))

$(eval $(call mldb_plugin_library,mongodb,bson,$(BSON_SRC_BUILD)))


###############################################################################
# Secondly, the mongodb c driver

MONGOC_SRC_FILES:=$(shell find $(CWD)/mongo-c-driver/src -wholename "mongo-c-driver/src/mongoc/*.c")
MONGOC_SRC_BUILD:=$(MONGOC_SRC_FILES:$(CWD)/%=%)
$(MONGOC_SRC_FILES): \
	$(CWD)/mongo-c-driver/src/mongoc/mongoc-config.h \
	$(CWD)/mongo-c-driver/src/mongoc/mongoc-version.h

# Rather than run automake and autoconf, etc we simply copy the file in
$(CWD)/mongo-c-driver/src/mongoc/mongoc-config.h: $(CWD)/mongoc-config.h
	@cp $< $@~ && mv $@~ $@
$(CWD)/mongo-c-driver/src/mongoc/mongoc-version.h: $(CWD)/mongoc-version.h
	@cp $< $@~ && mv $@~ $@

$(eval $(call set_compile_option,$(MONGOC_SRC_BUILD),-I$(LIBBSON)/src/bson -I$(LIBBSON)/src -DMONGOC_COMPILATION -Wno-maybe-uninitialized -Wno-deprecated-declarations))

$(eval $(call mldb_plugin_library,mongodb,mongoc,$(MONGOC_SRC_BUILD),bson))


###############################################################################
# Thirdly, the C++ wrapper for the BSON library

BSONCXX_SRC_FILES:=$(shell find $(CWD)/mongo-cxx-driver/src/bsoncxx -name "*.cpp" | grep -v test)
BSONCXX_SRC_BUILD:=$(BSONCXX_SRC_FILES:$(CWD)/%=%)
$(eval $(call set_compile_option,$(BSONCXX_SRC_BUILD),-I$(CWD)/mongo-cxx-driver/src -I$(CWD)/mongo-cxx-driver -I$(LIBBSON)/src/bson -I$(CWD)/mongo-c-driver/src -I$(LIBBSON)/src -I$(LIBBSON)/build/cmake/bson -I$(CWD)/mnmlstc/include -DMONGO_CXX_DRIVER_COMPILING))
$(BSONCXX_SRC_FILES): \
	$(CWD)/mongo-cxx-driver/src/bsoncxx/config/config.hpp \
	$(CWD)/mongo-cxx-driver/src/bsoncxx/config/version.hpp \
	$(CWD)/mongo-cxx-driver/src/bsoncxx/config/export.hpp

$(CWD)/mongo-cxx-driver/src/bsoncxx/config/%.hpp: $(CWD)/bsoncxx-%.hpp
	@cp $< $@~ && mv $@~ $@

$(eval $(call mldb_plugin_library,mongodb,bsoncxx,$(BSONCXX_SRC_BUILD),bson))


###############################################################################
# Finally, the C++ wrapper for the BSON library


MONGOCXX_SRC_FILES:=$(shell find $(CWD)/mongo-cxx-driver/src/mongocxx -name "*.cpp" | grep -v test)
MONGOCXX_SRC_BUILD:=$(MONGOCXX_SRC_FILES:$(CWD)/%=%)
$(MONGOCXX_SRC_FILES): \
	$(CWD)/mongo-cxx-driver/src/mongocxx/config/config.hpp \
	$(CWD)/mongo-cxx-driver/src/mongocxx/config/version.hpp \
	$(CWD)/mongo-cxx-driver/src/mongocxx/config/export.hpp

$(CWD)/mongo-cxx-driver/src/mongocxx/config/%.hpp: $(CWD)/mongocxx-%.hpp
	@cp $< $@~ && mv $@~ $@

$(eval $(call set_compile_option,$(MONGOCXX_SRC_BUILD),-I$(CWD)/mongo-cxx-driver/src -I$(CWD)/mongo-c-driver/src -I$(LIBBSON)/src -I$(CWD)/mongo-cxx-driver  -I$(CWD)/mnmlstc/include -I$(LIBBSON)/src/bson -I$(LIBBSON)/build/cmake/bson -I$(CWD)/mongo-c-driver/src/mongoc -DMONGO_CXX_DRIVER_COMPILING))

$(eval $(call mldb_plugin_library,mongodb,mongocxx,$(MONGOCXX_SRC_BUILD),bsoncxx mongoc))


###############################################################################
# Export what we need to include the headers

MONGOCXX_INCLUDE_FLAGS:=-I$(CWD)/mongo-cxx-driver/src -I$(CWD)/mongo-c-driver/src -I$(LIBBSON)/src -I$(CWD)/mongo-cxx-driver -I$(CWD)/mnmlstc/include -I$(LIBBSON)/src/bson -I$(LIBBSON)/build/cmake/bson -I$(CWD)/mongo-c-driver/src/mongoc -DMONGO_CXX_DRIVER_COMPILING


endif