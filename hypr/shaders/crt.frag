precision mediump float;

varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec2 uv = v_texcoord;

    // slight barrel distortion
    vec2 centered = uv - 0.5;
    float dist = dot(centered, centered);
    uv += centered * dist * 0.15;

    vec4 color = texture2D(tex, uv);

    // scanlines
    float scan = sin(v_texcoord.y * 900.0) * 0.03;
    color.rgb -= scan;

    // subtle vignette
    float vignette = smoothstep(0.8, 0.2, length(centered));
    color.rgb *= vignette;

    // slight color separation (chromatic aberration)
    float shift = 0.002;
    float r = texture2D(tex, uv + vec2(shift, 0.0)).r;
    float g = texture2D(tex, uv).g;
    float b = texture2D(tex, uv - vec2(shift, 0.0)).b;

    gl_FragColor = vec4(vec3(r, g, b), color.a);
}
