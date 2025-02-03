import nltk
from nltk.tokenize import word_tokenize

def pluralize_noun(noun):
    fsm = {
        "s": lambda x: x + "es" if x.endswith(("s", "x", "z", "ch", "sh")) else x + "s",
        "y": lambda x: x[:-1] + "ies" if x.endswith("y") and x[-2] not in "aeiou" else x + "s",
        "f": lambda x: x[:-1] + "ves" if x.endswith("f") else (x[:-2] + "ves" if x.endswith("fe") else x + "s"),
        "default": lambda x: x + "s"
    }
    
    if noun.endswith(("s", "x", "z", "ch", "sh")):
        return fsm["s"](noun)
    elif noun.endswith("y") and noun[-2] not in "aeiou":
        return fsm["y"](noun)
    elif noun.endswith("f") or noun.endswith("fe"):
        return fsm["f"](noun)
    else:
        return fsm["default"](noun)

def morphological_parsing(text):
    nltk.download('punkt')
    words = word_tokenize(text)
    pluralized_words = [pluralize_noun(word) for word in words]
    print("Original Words:", words)
    print("Pluralized Words:", pluralized_words)

if _name_ == "_main_":
    text = "cat dog fox bus leaf wife city."
    morphological_parsing(text)
