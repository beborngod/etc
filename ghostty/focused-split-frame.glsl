void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 color = texture(iChannel0, uv);
    float edge = min(min(fragCoord.x, iResolution.x - fragCoord.x), min(fragCoord.y, iResolution.y - fragCoord.y));

    if (iFocus > 0 && edge < 2.0) {
        color.rgb = vec3(65.0, 70.0, 71.0) / 255.0;
    }

    fragColor = color;
}
