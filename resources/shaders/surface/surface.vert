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

in  vec3 vtx_position;
in  vec3 vtx_normal;
in  vec3 vtx_color;
in  vec2 vtx_texcoord;

uniform vec4 default_color = vec4(0.4f, 0.8f, 0.8f, 1.0f);
uniform bool per_vertex_color = false;

uniform mat4 MVP;
uniform mat4 MANIP = mat4(1.0);
uniform mat3 NORMAL = mat3(1.0);

uniform bool planeClippingDiscard = false;
uniform bool clippingPlaneEnabled = false;
uniform bool crossSectionEnabled = false;
uniform vec4 clippingPlane0;
uniform vec4 clippingPlane1;


out Data{
    vec2 texcoord;
    vec4 color;
    vec3 position;
    vec3 normal;
    float clipped;
} DataOut;

void main() {
    vec4 new_position = MANIP * vec4(vtx_position, 1.0);

    DataOut.clipped = 0.0;
    if (clippingPlaneEnabled) {
        gl_ClipDistance[0] = dot(new_position, clippingPlane0);
        if (planeClippingDiscard && gl_ClipDistance[0] < 0)
            DataOut.clipped = 1.0;
        if (crossSectionEnabled) {
            gl_ClipDistance[1] = dot(new_position, clippingPlane1);
            if (planeClippingDiscard && gl_ClipDistance[1] < 0)
                DataOut.clipped = 1.0;
        }
    }

    if (per_vertex_color)
        DataOut.color = vec4(vtx_color, 1.0);
    else
        DataOut.color = default_color;

    DataOut.position = new_position.xyz;
    DataOut.normal = NORMAL * vtx_normal;
    DataOut.texcoord = vtx_texcoord;

    gl_Position = MVP * new_position;
}
