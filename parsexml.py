import xml.etree.ElementTree as ET
tree = ET.parse('../data/mit.meta.xml')
root = tree.getroot()

for child in root:

    id = child.find('id').text
    print id.encode('utf-8'),

    try:
        name = child.find('name').text
        print name.encode('utf-8'),
    except AttributeError:
        pass
    try:
        keywords = child.find('keywords').text
        print keywords.encode('utf-8'),
    except AttributeError:
        pass
    try:
        calendar = child.find('calendar').text
        print calendar.encode('utf-8'),
    except AttributeError:
        pass

    print ''
