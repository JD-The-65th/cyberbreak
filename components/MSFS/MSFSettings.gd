class_name MSFSettings

enum PARTICLE_TYPE 
{
	PARTICLES,
	TRAILS,
	BOTH
}

enum PARTICLE_SPEED
{
	SlOW,
	NORMAL,
	FAST,
	WILD
}

enum SIZE
{
	SMALL,
	NORMAL,
	LARGE
}

var particle_type : PARTICLE_TYPE = PARTICLE_TYPE.BOTH

var particle_size : SIZE = SIZE.NORMAL

var particle_amount : int = 16

var particle_speed : PARTICLE_SPEED = PARTICLE_SPEED.NORMAL

var one_shot : bool = false



