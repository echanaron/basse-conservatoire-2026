\version "2.26.0"

\language "français"
\pointAndClickOff

\paper {
	markup-system-spacing =
	#'((basic-distance . 18)
		(minimum-distance . 12)
		(padding . 2)
		(stretchability . 30))
%	property-defaults.fonts.serif = "Adobe Garamond Pro"
}

\header {
	title = "Basse chiffrée"
	subtitle = ""
	composer = \markup \right-column {
		"Texte : Holstein"
		"Réalisation : Étienne Chanaron"
	}
	tagline = ##f
}

global = {
	\key do \minor
	\time 4/4
}

% Portée supérieure

sopranoNotes = \relative do'' {
	\tempo "Lent."
	\voiceOne
	mib4( re2) mib4( | do sib mib fa | sol ré mib do | sib4. lab8 sib4.) fa'8 \break
	fa4( mib re do | si re do lab)~ | lab2 sol2~ | sol2 fa2 | \break
	sib4( sol fa mib | mib'2) fa2 | mib4( fa mib4 re | mib) do sib r |
}

altoNotes = \relative do'' {
	\voiceTwo
	sol8 lab8 sib2. | lab1 | sol4 fa mib fa~ | fa2~ fa4. r8 |
	sol1~ | sol1 | fa1 | mib2 fa2 |
	mib2 re4 mib4~ | mib4 lab2. | sol4 fa sol fa8( lab8 | sol4) mib8( fa8 sol4) r4 |
}

% Portée inférieure

tenorNotes = \relative do' {
	\voiceOne
	do4 fa2 mib4~ | mib4 re do sib~ | sib2. do4 | re4. do8 re4. r8 |
	re4 do si do | re4 si do2~ | do2 sib!2~ | sib2 lab4( sib8 lab8) |
	sol4 sib lab sib~ | sib do re2 | mib4 do sib2~ | sib4 lab sib r |
}

basseNotes = \relative do' {
	\voiceTwo
	do4( sib lab sol)~ | sol fa( mib re) | mib( fa sol lab) | sib-- fa-- sib,--~ sib8 r8 |
	si4( do re mib) | fa( sol8 fa8) mib4 lab | re,2.( sol4) | do,2( re2) |
	mib4 mib,( fa sol)~ | sol fa( sib2) | do4( lab sib2) | mib,2~ mib4 r4 |
	\bar "|."
}

nuancesGlobales = {
	s4\p\< s4 s4 s4 | s4\mf s4 s4 s4 | s4\> s4 s4 s4 | s4\p s4 s4 s4 | s1 * 3 | s4\> s4 s4 s8 s8\! | s4 s4 s4 s4 |
	s1 | s4\< s4 s4 s8 s8\mf |
}

% Chiffrage

chiffrage = \figuremode {
	\bassFigureExtendersOn
	<5>8 <6>8 <5>4 <5> <6> | <2> <6\+> <6 4> <6\! 5/> | <5> <6 4> <6\!> <6\!> | <5\!>4 <5>8 <5\!>8 <5\!>4 <5>8 r |
	<6\! 5/>4 <5> <6! 4> <6> | <4\+> <4\+>8 <4\+>8 <6>4 <7> | <7\!>2 <4 3>4 <4 3> | <7>2 <5/>4 <6>8 <5/>8 |
	<5>4 <5> <6\+ 3> <6\!> | <6> <7> <7\! _\+>2 | <5>4 <6> <6\! 4> <5>8 <7 _\+>8 | <5>4 <6 4>8 <2>8 <5>4 r |
}

% Structure

\score {
	\new PianoStaff <<
		
		\new Staff = "dessus" <<
			\global
			\clef treble
			\set Staff.midiInstrument = #"choir aahs"
			\new Voice = "soprano" \sopranoNotes
			\new Voice = "alto" \altoNotes
		>>

		\new Dynamics { \nuancesGlobales }

		\new Staff = "basse" <<
			\global
			\clef bass
			\set Staff.midiInstrument = #"choir aahs"
			\new Voice = "tenor" \tenorNotes
			\new Voice = "basse" \basseNotes
		>>

		\new FiguredBass \chiffrage
	>>

	\layout {
		% Configuration spécifique pour les portées (Staff)
		\context {
			\Staff
			\override FiguredBassPositioner.quantized-spacings = ##t
		}

		% Configuration globale pour toute la partition (Score)
		\context {
			\Score
			\remove "Bar_number_engraver"
		}
	}

	\midi {
		\context {
		\Score
		}
	}
}
