require 'drb/drb'

REMOTE_URI = 'druby://dbc-chicago-017.local:8787'

DRb.start_service

server = DRbObject.new_with_uri(REMOTE_URI)

server.notifier.notify("Foo")
