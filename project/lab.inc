/*****************************************************************************

		Copyright (c) My Company

 Project:  lab
 FileName: LAB.INC
 Purpose:  Project's global declarations
 Written by: Visual Prolog
 Comments:
*****************************************************************************/

constants
%BEGIN_CONST Project configuration constants, Code automatically updated!
  use_mdi = 1
  use_3dctrl = 1
  use_tbar = 1
  use_dlgpack = 1
  use_editor = 1
  use_message = 1
%END_CONST

include "vpi.con"
include "vpi.dom"
include "vpi.pre"


/*****************************************************************************
			User's Declarations
*****************************************************************************/
global domains
  DB_SELECTOR = browselist_db	% For treebrowser tool
  FILE = fileselector1; fileselector2 % To be edited

include "lab.pre"

include "vpitools.dom"
include "vpitools.pre"
