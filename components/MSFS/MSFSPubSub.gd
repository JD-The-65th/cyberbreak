extends Node
class_name MSFSPubSub

# XR Specific Variables
var head_emitter
var left_hand_emitter
var right_hand_emitter

# Game Anignostic Variables

## Array containing Node, Callable, Int Identidier
## EG:
## var update_callable = Callable(self, "push_settings")
## var emv_emitter = [MSFSParticleEmitter, update_callable, 3]
var environment_emitters = {} 

enum EMITTER_TYPES 
{
	HEADSET,
	LEFT_HAND,
	RIGHT_HAND,
	ENVIRONMENT
}

func register(type: EMITTER_TYPES, emitter_array: Array):
	if type == EMITTER_TYPES.ENVIRONMENT:
		environment_emitters += emitter_array
	else:
		if type == EMITTER_TYPES.HEADSET:
			head_emitter = emitter_array
		elif type == EMITTER_TYPES.LEFT_HAND:
			left_hand_emitter = emitter_array
		else:
			right_hand_emitter = emitter_array



