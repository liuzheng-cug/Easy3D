#version 150
// please send comments or report bug to: liangliang.nan@gmail.com

// It uses geometry shader for vertex generation.
// The code does not cover round caps.

//#extension GL_EXT_gpu_shader4 : enable

uniform mat4 MANIP = mat4(1.0);
uniform mat4 MV;

uniform bool planeClippingDiscard = false;
uniform bool clippingPlaneEnabled = false;
uniform bool crossSectionEnabled = false;
uniform vec4 clippingPlane0;
uniform vec4 clippingPlane1;

uniform vec4 default_color;
uniform bool per_vertex_color;

in  vec3 vtx_position;	// point position
in  vec3 vtx_color;	// point color

out Data {
    vec4 color;
    float clipped;
} DataOut;

void main()
{
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

    gl_Position = MV * new_position;

    if (per_vertex_color)
        DataOut.color = vec4(vtx_color, 1.0);
    else
        DataOut.color = default_color;
}
