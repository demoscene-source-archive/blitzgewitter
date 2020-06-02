#version 330

uniform sampler2D tex0;
uniform sampler2D tex1;
uniform int frame_num;
uniform float fade;
uniform vec3 addcolour;

noperspective in vec2 v2f_coord;

out vec4 output_colour;

float vignet()
{
    return 0.5 + 0.5*pow( 16*v2f_coord.x*v2f_coord.y*(1-v2f_coord.x)*(1-v2f_coord.y), 0.1 );
}

void main()
{
    output_colour.a = 0.0;
    output_colour.rgb = texture2D(tex0, v2f_coord).rgb;
        
    output_colour.rgb = pow(output_colour.rgb, vec3(0.8)) * vignet() * fade +
        texelFetch(tex1, ivec2(mod(gl_FragCoord.xy + ivec2(frame_num * ivec2(23, 7)), textureSize(tex1, 0))), 0).rrr  / 255.0;

   output_colour.rgb += addcolour;
}
