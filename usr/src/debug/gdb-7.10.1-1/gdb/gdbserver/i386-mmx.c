/* *INDENT-OFF* */ /* THIS FILE IS GENERATED */

/* A register protocol for GDB, the GNU debugger.
   Copyright (C) 2001-2013 Free Software Foundation, Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* This file was created with the aid of ``regdat.sh'' and ``/wip/cygport-git/gdb/gdb-7.10.1-1.i686/src/gdb-7.10.1/gdb/gdbserver/../regformats/i386/i386-mmx.dat''.  */

#include "server.h"
#include "regdef.h"
#include "tdesc.h"

static struct reg regs_i386_mmx[] = {
  { "eax", 0, 32 },
  { "ecx", 32, 32 },
  { "edx", 64, 32 },
  { "ebx", 96, 32 },
  { "esp", 128, 32 },
  { "ebp", 160, 32 },
  { "esi", 192, 32 },
  { "edi", 224, 32 },
  { "eip", 256, 32 },
  { "eflags", 288, 32 },
  { "cs", 320, 32 },
  { "ss", 352, 32 },
  { "ds", 384, 32 },
  { "es", 416, 32 },
  { "fs", 448, 32 },
  { "gs", 480, 32 },
  { "st0", 512, 80 },
  { "st1", 592, 80 },
  { "st2", 672, 80 },
  { "st3", 752, 80 },
  { "st4", 832, 80 },
  { "st5", 912, 80 },
  { "st6", 992, 80 },
  { "st7", 1072, 80 },
  { "fctrl", 1152, 32 },
  { "fstat", 1184, 32 },
  { "ftag", 1216, 32 },
  { "fiseg", 1248, 32 },
  { "fioff", 1280, 32 },
  { "foseg", 1312, 32 },
  { "fooff", 1344, 32 },
  { "fop", 1376, 32 },
};

static const char *expedite_regs_i386_mmx[] = { "ebp", "esp", "eip", 0 };
static const char *xmltarget_i386_mmx = "i386-mmx.xml";

const struct target_desc *tdesc_i386_mmx;

void
init_registers_i386_mmx (void)
{
  static struct target_desc tdesc_i386_mmx_s;
  struct target_desc *result = &tdesc_i386_mmx_s;

  result->reg_defs = regs_i386_mmx;
  result->num_registers = sizeof (regs_i386_mmx) / sizeof (regs_i386_mmx[0]);
  result->expedite_regs = expedite_regs_i386_mmx;
  result->xmltarget = xmltarget_i386_mmx;

  init_target_desc (result);

  tdesc_i386_mmx = result;
}