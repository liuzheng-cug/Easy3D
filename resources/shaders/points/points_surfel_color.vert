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

#version 330   // for geometry shader to work


in  vec3 vtx_position;// point position
in  vec3 vtx_color;// point color
in  vec3 vtx_normal;// point normal

uniform mat4 MANIP = mat4(1.0);
uniform mat3 NORMAL = mat3(1.0);

uniform vec4 default_color;
uniform bool per_vertex_color;

out VertexData
{
    vec4  color;
    vec3  normal;
} vertexOut;


void main()
{
    vec4 new_position = MANIP * vec4(vtx_position, 1.0);

    gl_Position = new_position;

    if (per_vertex_color)
        vertexOut.color = vec4(vtx_color, 1.0f);
    else
        vertexOut.color = default_color;

    vertexOut.normal = NORMAL * vtx_normal;
}
