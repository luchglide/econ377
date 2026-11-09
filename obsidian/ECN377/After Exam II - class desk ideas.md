# After Exam II: class desk ideas

Noted Mon Nov 9, to pick up after the exam on Wed Nov 11.

## 1. Host the class desk as a private site (Vercel)
- Goal: open my notes for every class from anywhere, not just on the Mac.
- Must be private: a login in front of everything (notes, transcripts, recordings).
- Things to decide:
  - What gets hosted: the notes viewer and search only, or recording too? Recording and Whisper run on the Mac today; Vercel can't run Whisper the same way.
  - Where notes live: they are files on the Mac now (`~/Documents/School/Fall-2026/<course>/notes`). A hosted site needs them synced somewhere (a private GitHub repo or a database).
  - Recordings are large (50-120 MB each): keep them on the Mac, host only notes and transcripts.

## 2. Make the notes searchable for answers
- Search across every class: typed notes, "(from recording)" notes, transcripts.
- Enhance the notes so answers are easy to find:
  - one consistent heading per topic, with the formula, a worked example and the R code;
  - a "professor flagged" list per class (the ⭐ items);
  - links from each topic to the matching `exam2.R` block and problem-set question.

## 3. Exam rule to design around
- ECN 377 exams are open-note but NOT open-internet (syllabus). A hosted site can't be used during an exam.
- So also build an offline copy: one searchable file per course (HTML or PDF) saved on the computer, rebuilt after each class.

## Status on Nov 9
- Auto notes after each transcription and live notes during class: being installed on the Mac.
- Backfill of past recordings: in progress.
