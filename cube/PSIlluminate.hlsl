//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct PSIn
{
	float4 Pos : SV_Position;
	float2 Tex : TEXCOORD;
};

cbuffer cbPerframe : register(b0)
{
	float4 g_lightPos;
	float4 g_eyePos;
};

SamplerState	g_smpLinear	: register(s0, space1);
Texture2D		g_txDiffuse	: register(t0, space2);
Texture2D		g_txNormal	: register(t1, space2);

float4 main(PSIn input) : SV_TARGET
{
	const float3 upDir = float3(0.0, 1.0, 0.0);
	const float4 light = 5.0;
	const float4 ambient = 1.2.xxxx;

	float4 diffuse = g_txDiffuse.Sample(g_smpLinear, input.Tex);
	float4 norm = g_txNormal.Sample(g_smpLinear, input.Tex);
	norm.xyz = norm.xyz * 2.0 - 1.0;

	//float3 lightDir = normalize(g_lightPos.xyz - wpos);
	float3 lightDir = normalize(g_lightPos.xyz);

	float lightAmt = saturate(dot(norm.xyz, lightDir));
	float ambientAmt = saturate(dot(norm.xyz, upDir) * 0.5 + 0.5);
	float4 lightColor = light * lightAmt + ambient * ambientAmt;

	//float3 viewDir = normalize(g_eyePos.xyz - WPos);
	float3 viewDir = normalize(g_eyePos.xyz);
	float3 halfAngle = normalize(lightDir + viewDir);
	float specAmt = saturate(dot(norm.xyz, halfAngle));
	float4 spec = pow(specAmt, 32.0) * 1.0;

	float4 result = lightColor * diffuse + spec;
	result.w = diffuse.w;
	
	// Simple tone mapping
	result.xyz /= result.xyz + 1.0;
	result.xyz *= result.xyz;

	return result;
}
