//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct VSOut
{
	float4 Pos : SV_Position;
	float2 Tex : TEXCOORD;
};

VSOut main(uint vid : SV_VertexID) 
{
	VSOut output;
	output.Tex = 2.0 * float2(vid >> 1, vid & 1);
	output.Pos = float4(output.Tex * 2.0 - 1.0, 0.5, 1.0);

	return output;
}
