import (
	"time"
)

// Date is a date in the format YYYY-MM-DD
#Timestamp: time.Format(time.RFC3339)

#TypeURI: string

#BaselineControlID: =~"^OSPS-[A-Z]{2}-[0-9]{2}.[0-9]{2}$"

#ResourceDescriptor: {
	description: string
	mediaType:   string
	uri:         #TypeURI
}

#Ella: {
	uri:     #TypeURI
	uriData: _ // see https://cuelang.org/docs/tour/types/top/
}

#EllaEvidence: {
	name?: string
	ella:  #Ella
}

#HumanEvidence: {
	name?:            string
	humanDescription: string
}

#AttestationRefEvidence: {
	name?: string
	ref:   #ResourceDescriptor
}

#Evidence: {
	ellaEvidence?:           #EllaEvidence
	humanEvidence?:          #HumanEvidence
	attestationRefEvidence?: #AttestationRefEvidence
}

#Control: {
	id:         #BaselineControlID
	conclusion: "compliant" | "non-compliant"
	evidence: [#Evidence, ...#Evidence]
}

#Evaluator: {
	id:      #TypeURI
	comment: string
}

#BaselinePredicate: {
	assessedAt:        #Timestamp
	assessedBy:        #Evaluator
	assessmentComment: string
	controls: [#Control, ...#Control]
	baselineLevel?:   int
	baselineVersion?: string
}
