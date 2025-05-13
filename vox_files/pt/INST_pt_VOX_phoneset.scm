;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                     Carnegie Mellon University                      ;;;
;;;                  and Alan W Black and Kevin Lenzo                   ;;;
;;;                      Copyright (c) 1998-2000                        ;;;
;;;                        All Rights Reserved.                         ;;;
;;;                                                                     ;;;
;;; Permission is hereby granted, free of charge, to use and distribute ;;;
;;; this software and its documentation without restriction, including  ;;;
;;; without limitation the rights to use, copy, modify, merge, publish, ;;;
;;; distribute, sublicense, and/or sell copies of this work, and to     ;;;
;;; permit persons to whom this work is furnished to do so, subject to  ;;;
;;; the following conditions:                                           ;;;
;;;  1. The code must retain the above copyright notice, this list of   ;;;
;;;     conditions and the following disclaimer.                        ;;;
;;;  2. Any modifications must be clearly marked as such.               ;;;
;;;  3. Original authors' names are not deleted.                        ;;;
;;;  4. The authors' names are not used to endorse or promote products  ;;;
;;;     derived from this software without specific prior written       ;;;
;;;     permission.                                                     ;;;
;;;                                                                     ;;;
;;; CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK        ;;;
;;; DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING     ;;;
;;; ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT  ;;;
;;; SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE     ;;;
;;; FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   ;;;
;;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN  ;;;
;;; AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,         ;;;
;;; ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      ;;;
;;; THIS SOFTWARE.                                                      ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Phonset for INST_pt
;;;

;;;  Feeel free to add new feature values, or new features to this
;;;  list to make it more appropriate to your language

;; This is where it'll fall over if you haven't defined a 
;; a phoneset yet, if you have, delete this, if you haven't
;; define one then delete this error message
(error "You have not yet defined a phoneset for pt (and others things ?)\n            Define it in festvox/INST_pt_VOX_phoneset.scm\n")

(defPhoneSet
  INST_pt
  ;;;  Phone Features
  (;; vowel or consonant
   (clst + - 0)
   (vc + - 0)
   ;; vowel length: short long dipthong schwa
   (vlng s l d a 0)
   ;; vowel height: high mid low
   (vheight 1 2 3 0 -)
   ;; vowel frontness: front mid back
   (vfront 1 2 3 0 -)
   ;; lip rounding
   (vrnd + - 0)
   ;; consonant type: stop fricative affricative nasal liquid approximant
   (ctype s f a n l r 0)
   ;; place of articulation: labial alveolar palatal
   ;; labio-dental dental velar glottal
   (cplace l a p b d v g 0)
   ;; consonant voicing
   (cvox + - 0)
   (asp  + - 0)
   (nuk + - 0)
   )
  (
;; Silence phonemes
   (    pau   -   -   0   0   0   0   0   0   -   -   -   ) ;; long silence
   (    sp   -   -   0   0   0   0   0   0   -   -   -   ) ;; short silence

;; Based on:
;; https://en.wikipedia.org/wiki/Portuguese_phonology

;; Ordinary vowels and glides.

   (    a   -   +   0   3   2   -   0   0   -   -   -   )
   (    i   -   +   0   1   1   -   0   p   -   -   -   )
   (    e   -   +   0   2   1   -   0   p   -   -   -   )
   (    o   -   +   0   2   3   +   0   v   -   -   -   )
   (    u   -   +   0   3   3   +   0   v   -   -   -   )
   (    ɐ   -   +   0   2   0   0   0   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/Near-open_central_vowel
   (    ɔ   -   +   0   3   3   +   0   v   -   -   -   )
   (    ɛ   -   +   0   3   1   -   0   p   -   -   -   )
   (    ø   -   +   0   2   1   +   0   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/Close-mid_front_rounded_vowel
   (    j   -   +   0   0   0   0   0   0   -   -   -   )
   (    w   -   +   0   0   0   0   0   0   -   -   -   )

;; Nasalized vowels and glides.
;; Note the upstream template occasionally generates "double-nasalization",
;; i.e., vowels followed by two combining tildes. This is ignored since 
;; it's not clear what this means.

   (    ɐ̃   -   +   0   1   2   0   n   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/Nasal_vowel
   (    ẽ   -   +   0   2   1   -   n   p   -   -   -   ) 
   (    ĩ   -   +   0   1   1   -   n   p   -   -   -   )
   (    õ   -   +   0   2   3   +   n   v   -   -   -   )
   (    ũ   -   +   0   1   3   +   n   v   -   -   -   )
   (    ɔ̃   -   +   0   2   3   +   n   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/Open-mid_back_rounded_vowel
   (    ɛ̃   -   +   0   2   1   -   n   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/Open-mid_front_unrounded_vowel
   (    ã   -   +   0   0   2   0   n   0   -   -   -   ) ;; https://en.wikipedia.org/wiki/%C3%83
   (    j̃   -   +   0   0   0   0   n   p   -   -   -   ) ;; https://en.wikipedia.org/wiki/Nasal_palatal_approximant
   (    w̃   -   +   0   0   0   0   n   v   -   -   -   ) ;; https://en.wikipedia.org/wiki/Nasal_labial%E2%80%93velar_approximant

;; Consonants 
;; Postalveolar = alveolar
   (    ɾ   +   -   0   0   0   0   l   a   +   -   -   )
   (    s   +   -   0   0   0   0   f   0   -   -   -   )
   (    k   +   -   0   0   0   0   -   v   -   -   -   )
   (    t   +   -   0   0   0   0   -   0   -   -   -   )
   (    d   +   -   0   0   0   0   -   0   +   -   -   )
   (    m   +   -   0   0   0   0   n   0   +   -   -   )
   (    l   +   -   0   0   0   0   l   a   +   -   -   )
   (    n   +   -   0   0   0   0   n   a   +   -   -   )
   (    ʁ   +   -   0   0   0   0   f   v   +   -   -   ) ;; https://en.wikipedia.org/wiki/Voiced_uvular_fricative
   (    t͡ʃ   +   -   0   0   0   0   a   a   -   -   -   ) ;; https://en.wikipedia.org/wiki/Voiceless_postalveolar_affricate
   (    p   +   -   0   0   0   0   -   0   -   -   -   )
   (    z   +   -   0   0   0   0   f   0   +   -   -   )
   (    ʃ   +   -   0   0   0   0   f   p   -   -   -   )
   (    b   +   -   0   0   0   0   -   0   +   -   -   )
   (    f   +   -   0   0   0   0   f   b   -   -   -   )
   (    ɡ   +   -   0   0   0   0   -   v   +   -   -   ) 
   (    kʷ   +   -   0   0   0   0   s   v  -   -   -   ) ;; https://en.wikipedia.org/wiki/Labialization
   (    ɡʷ   +   -   0   0   0   0   s   v   +   -   -   ) ;; # This gu in European, apparently. ;; https://en.wikipedia.org/wiki/Labialization
   (    d͡ʒ   +   -   0   0   0   0   a   a   +   -   -   ) ;; https://en.wikipedia.org/wiki/Voiced_postalveolar_affricate
   (    v   +   -   0   0   0   0   f    b  +   -   -   )
   (    ɻ   +   -   0   0   0   0   r   a   -   -   -   ) ;; https://en.wikipedia.org/wiki/Voiced_retroflex_approximant
   (    ʒ   +   -   0   0   0   0   f   p   +   -   -   )
   (    ɲ   +   -   0   0   0   0   n   p   +   -   -   )
   (    ʎ   +   -   0   0   0   0   l   p   +   -   -   )
   ;; insert the phones here, see exmples in 
   ;; festival/lib/*_phones.scm

  )
)

(PhoneSet.silences '(pau))

(define (INST_pt_VOX::select_phoneset)
  "(INST_pt_VOX::select_phoneset)
Set up phone set for INST_pt."
  (Parameter.set 'PhoneSet 'INST_pt)
  (PhoneSet.select 'INST_pt)
)

(define (INST_pt_VOX::reset_phoneset)
  "(INST_pt_VOX::reset_phoneset)
Reset phone set for INST_pt."
  t
)

(provide 'INST_pt_VOX_phoneset)
