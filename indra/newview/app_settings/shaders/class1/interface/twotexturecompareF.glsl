/** 
 * @file twotexturecompareF.glsl
 *
 * $LicenseInfo:firstyear=2007&license=viewerlgpl$
 * Second Life Viewer Source Code
 * Copyright (C) 2007, Linden Research, Inc.
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation;
 * version 2.1 of the License only.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 * Linden Research, Inc., 945 Battery Street, San Francisco, CA  94111  USA
 * $/LicenseInfo$
 */

#ifdef DEFINE_GL_FRAGCOLOR
out vec4 frag_color;
#else
#define frag_color gl_FragColor
#endif

uniform sampler2D tex0;
uniform sampler2D tex1;

VARYING vec2 vary_texcoord0;
VARYING vec2 vary_texcoord1;

void main() 
{
	frag_color = texture2D(tex0, vary_texcoord0.xy) - texture2D(tex1, vary_texcoord0.xy);
	
	if(frag_color[0] < 0.f)
	{
		frag_color[0] = -frag_color[0];
	}
	if(frag_color[1] < 0.f)
	{
		frag_color[1] = -frag_color[1];
	}
	if(frag_color[2] < 0.f)
	{
		frag_color[2] = -frag_color[2];
	}
	frag_color[3] = 1.f;
}
