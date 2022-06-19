from rest_framework import serializers
from chat.models import Room, Message
from datetime import datetime


class RoomSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    name = serializers.CharField(required=True, allow_blank=False, max_length=1000)

    def create(self, validated_data):
        return Room.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.save()
        return instance

class MessageSerializer(serializers.Serializer):
    body = serializers.CharField(max_length=1000000)
    date = serializers.DateTimeField(default=datetime.now)
    user = serializers.CharField(max_length=1000000)
    room = serializers.CharField(max_length=1000000)

    def create(self, validated_data):
        return Message.objects.create(**validated_data)
