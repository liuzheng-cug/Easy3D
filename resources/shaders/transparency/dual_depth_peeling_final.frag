/********************************************************************
 * Copyright (C) 2015 Liangliang Nan <liangliang.nan@gmail.com>
 * https://3d.bk.tudelft.nl/liangliang/
 *
 * This file is part of Easy3D. If it is useful in your research/work,
 * I would be grateful if you show your appreciation by citing it:
 * ------------------------------------------------------------------
 *      Liangliang Nan.
 *      Easy3D: a lightweight, easy-to-use, and efficient C++
 *      library for processing and rendering 3D data. 2018.
 * ------------------------------------------------------------------
 * Easy3D is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License Version 3
 * as published by the Free Software Foundation.
 *
 * Easy3D is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 ********************************************************************/

#version 150
precision highp float;

in vec2 texCoord;

uniform sampler2D FrontBlenderTex;
uniform sampler2D BackBlenderTex;

out vec4 fragOutput;

void main(void)
{
	vec4 frontColor = texture(FrontBlenderTex, texCoord);
	vec3 backColor = texture(BackBlenderTex, texCoord).rgb;
	float alphaMultiplier = 1.0 - frontColor.w;

	// front + back
	fragOutput.rgb = frontColor.rgb + backColor * alphaMultiplier;

	// Liangliang: I don't want transparent images
	fragOutput.a = 1.0f;
}



