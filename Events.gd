extends Node

var consumers = {}

func emit(event, args:Array = []):
	if !consumers.has(event):
		return
	
	for consumer in consumers[event]:
		consumer.instance.callv(consumer.method, args)

func listen(event: String, instance, method: String):
	if !consumers.has(event):
		consumers[event] = []

	var consumersForEvent = consumers[event]
	consumersForEvent.append({
		"instance": instance,
		"method": method
	})

	consumers[event] = consumersForEvent
