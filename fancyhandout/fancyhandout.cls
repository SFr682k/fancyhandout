% This is fancyhandout.cls, development version
% licensed under the LPPL v1.3c or any later version
% Copyright 2017 Sebastian Friedl
% Current maintainer: Sebsatian Friedl <sfr682k@t-online.de>


\ProvidesClass{fancyhandout}[2017/12/08 fancyhandout development version]


% TODO: Provide font selection options & option to deactivate 2 page layout
\LoadClass[twoside,11pt]{article}

\newif\if@letter
\@letterfalse
\DeclareOption{letter}{\@lettertrue}

\newif\if@sffont
\@sffonttrue
\DeclareOption{rmfont}{\@sffontfalse}

\ProcessOptions


% Page layout & margins
\if@letter	\RequirePackage[letterpaper, twoside, left=2.25cm, right=2.25cm, top=2.25cm, bottom=2.25cm, includehead, includefoot]{geometry}
\else		\RequirePackage[a4paper,     twoside, left=2.25cm, right=2.25cm, top=2.25cm, bottom=2.25cm, includehead, includefoot]{geometry}
\fi

% Default font
\if@sffont	\def\familydefault{\sfdefault}
\fi


% TODO: Load fancyhdr

\RequirePackage{enumitem}
	\setlist{itemsep=0ex,topsep=.75ex}


% TODO: Redefine \section etc.


%\RequirePackage{tikz}
% TODO: Beamer styled boxes!!