syn keyword cppSTL		std stdext boost dump string vector map deque unordered_map
syn keyword cppSTL		BaseNodePtr TNodePtr NodePtr GCPtr  NodeWeakPtr TNodeWeakPtr BaseWeakNodePtr GCWeakPtr  BranchPtr  NeuritePtr NeuriteWeakPtr  NeuronPtr NeuronWeakPtr  ActinPtr ActinWeakPtr
syn keyword cppSTLtype		uchar ushort uint ulong int8_t int16_t int32_t int64_t uint8_t uint16_t uint32_t uint64_t int8 int16 int32 int64 uint8 uint16 uint32 uint64
syn match cUserBracketCharacter display "[~!&()[\]{},.<>?:;]"
syn match cUserBracketCharacter display "(->)"
syn match cUserSpecialCharacter display "=+*-\/%"
syn match Private display "[_a-zA-Z]*_[ ;.(),:=-+]"

command -nargs=+ HiLink hi def link <args>
HiLink cppSTL				Identifier
HiLink cppSTLtype         Type
delcommand HiLink


