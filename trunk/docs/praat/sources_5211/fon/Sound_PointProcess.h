/* Sound_PointProcess.h
 *
 * Copyright (C) 2010 Paul Boersma
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * pb 2010/12/09
 */

#ifndef _Sound_h_
	#include "Sound.h"
#endif
#ifndef _PointProcess_h_
	#include "PointProcess.h"
#endif

Sound Sound_PointProcess_to_SoundEnsemble_correlate (Sound me, PointProcess thee, double tmin, double tmax);

/* End of file Sound_PointProcess.h */
