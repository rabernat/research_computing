from pelican import signals, readers, contents
old_tag = '<table>'
new_tag = '<table class="table table-striped table-hover">'

def bootswatch_markdown_css(content):
    if content._content == None:
        return
    src = content._content
    content._content = src.replace(old_tag, new_tag)

def register():
    signals.content_object_init.connect(bootswatch_markdown_css)
