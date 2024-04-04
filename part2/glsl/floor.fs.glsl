in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 texCoord;
in vec4 lightSpaceCoords;

uniform vec3 lightColor;
uniform vec3 ambientColor;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform vec3 cameraPos;
uniform vec3 lightPosition;
uniform vec3 lightDirection;

// Textures are passed in as uniforms
uniform sampler2D colorMap;
uniform sampler2D normalMap;

// Added ShadowMap
uniform sampler2D shadowMap;
uniform vec2 textureSize;

//Q1d do the shadow mapping
//Q1d iii do PCF
// Returns 1 if point is occluded (saved depth value is smaller than fragment's depth value)
float inShadow() {
	vec4 projCoords = lightSpaceCoords / lightSpaceCoords.w;
	vec4 uvCoord = 0.5 * lightSpaceCoords + 0.5;
	float zbufdepth = texture2D(shadowMap, uvCoord.xy).x;
	return zbufdepth < uvCoord.z ? 1.0 : 0.0;
}

// TODO: Returns a value in [0, 1], 1 indicating all sample points are occluded
float calculateShadow() {
	float occludedSamples = 0.0;
	vec2 pixelOffset = (1.0 / textureSize) + 0.0001;
	vec4 projCoords = lightSpaceCoords / lightSpaceCoords.w;
	vec4 uvCoord = 0.5 * lightSpaceCoords + 0.5;
	

	//center pixel
	if(texture2D(shadowMap, uvCoord.xy).x < uvCoord.z)
		occludedSamples += 1.0;

	//left pixel
	if(texture2D(shadowMap, uvCoord.xy + vec2(-pixelOffset.x, 0.0)).x < uvCoord.z)
		occludedSamples += 1.0;

	//right pixel
	if(texture2D(shadowMap, uvCoord.xy + vec2(pixelOffset.x, 0.0)).x < uvCoord.z)
		occludedSamples += 1.0;
	
	//top pixel
	if(texture2D(shadowMap, uvCoord.xy + vec2(0.0, pixelOffset.y)).x < uvCoord.z)
		occludedSamples += 1.0;
	
	//bottom pixel
	if(texture2D(shadowMap, uvCoord.xy + vec2(0.0, -pixelOffset.y)).x < uvCoord.z)
		occludedSamples += 1.0;

	return occludedSamples / 5.0;
}

void main() {
	//PRE-CALCS
	vec3 N = normalize(vcsNormal);
	vec3 Nt = normalize(texture(normalMap, texCoord).xyz * 2.0 - 1.0);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 V = normalize(-vcsPosition);
	vec3 H = normalize(V + L);

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient;

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor;
	vec3 light_DFF = diffuse * max(0.0, dot(N, L));

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, N)), shininess);

	//SHADOW
	// TODO:
	float shadow = 1.0 - calculateShadow();

	//TOTAL
	vec2 newtexCoord = vec2(texCoord.x, texCoord.y);
	light_DFF *= texture(colorMap, texCoord).xyz;
	vec3 TOTAL = light_AMB + shadow * (light_DFF + light_SPC);
	
	gl_FragColor = vec4(TOTAL, 1.0);
}