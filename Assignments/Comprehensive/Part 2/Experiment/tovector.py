import re

pattern = re.compile(r"Total runtime: (.+?)m(.+?)s")

with open("out.txt", "w") as out:
    for i in range(41):
        with open("{}.txt".format(i), "r") as f:
            content = f.readlines()
            content = content[4]
            m = pattern.match(content)
            if m is not None:
                minutes = int(m.group(1))
                seconds = float(m.group(2))
                total = minutes * 60 + seconds
                out.write("%f, " % total)
            else:
                print("No match in {}.txt!".format(i))
