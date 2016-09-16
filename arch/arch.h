/* arch.h                                                          -*- C++ -*-
   Jeremy Barnes, 22 February 2007
   Copyright (c) 2007 Jeremy Barnes.  All rights reserved.
   This file is part of MLDB. Copyright 2015 Datacratic. All rights reserved.

   Detection of the architecture.
*/

#pragma once

#if defined(__i386__) || defined(__amd64__)
# define JML_INTEL_ISA 1
#elif defined (__aarch64__) || defined(__arm__)
# define JML_ARM_ISA 1
#endif // intel ISA

# if defined(__amd64__) || defined(__aarch64__)
#  define JML_BITS 64
# else
#  define JML_BITS 32
# endif // 32/64 bits
