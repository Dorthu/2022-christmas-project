"""
This is the main controller for the entire game, which handles management of all systems and trasitions
between levels.  This controller is a globally-referencable singleton.
"""
extends Node

var canPanCamera: bool = true
var currentLevel: Level = null
var root: main = null
