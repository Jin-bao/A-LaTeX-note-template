% note.cls
\ProvidesClass{note}[2020/3/29 v4.0 Physics and Mathematics note template.]
\NeedsTeXFormat{LaTeX2e}

% 颜色包
\RequirePackage{xcolor}
\definecolor{pagecolor}{cmyk}{0,0,0,0.06}

% 初始设定和选项声明
\newif\ifoneside\onesidefalse
\newif\ifminitoc\minitocfalse

\DeclareOption{oneside}{%
    \onesidetrue
    \PassOptionsToClass{oneside}{book}
}
\DeclareOption{drafttrue}{% 开启草稿模式
    \PassOptionsToPackage{draft}{flowfram}
}
\DeclareOption{minitoc}{% 开启章标题页的小型目录
    \minitoctrue
}
\DeclareOption{greentheme}{% 绿色主题
    \definecolor{themecolor}{cmyk}{0.64,0,0.95,0.50}
}
\DeclareOption{darkgreentheme}{% 深绿色主题
    \definecolor{themecolor}{cmyk}{0.64,0,0.95,0.64}
}
\DeclareOption{browntheme}{% 棕色主题
    \definecolor{themecolor}{cmyk}{0.36,0.47,0.82,0.51}
}
\DeclareOption{darkredtheme}{% 深洋红色主题
    \definecolor{themecolor}{cmyk}{0.05,1,0.6,0.6}
}
\DeclareOption{darkbluetheme}{% 暗蓝色主题
    \definecolor{themecolor}{cmyk}{1,0.3,0.1,0.62}
}
\DeclareOption{darktheme}{% 深灰色主题
    \definecolor{themecolor}{cmyk}{0.02,0.02,0.02,0.98}
}
\ExecuteOptions{greentheme}% 默认是绿色主题
\ProcessOptions

% 导入基础类
\LoadClass{book}%[oneside]
\RequirePackage{makeidx}
\makeindex
\makeatletter
\renewcommand\appendix{\cleardoublepage
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \gdef\@chapapp{\appendixname}%
    \gdef\thechapter{\@Alph\c@chapter}}
\def\bibliography#1{%
    \if@filesw
        \immediate\write\@auxout{\string\bibdata{\zap@space #1 \@empty}}
    \fi
    \@input@{\jobname.bbl}\setcounter{chapter}{0}}
\let\oldprintindex\printindex
\def\printindex{\oldprintindex\setcounter{chapter}{0}}
\makeatother

% 重定义预定名
\renewcommand{\contentsname}{目 \quad 录}
\renewcommand{\appendixname}{附录 \thechapter}
\renewcommand{\bibname}{参考文献}
\renewcommand{\indexname}{索 \quad 引}
\renewcommand{\partname}{第 \thepart 部分}
\renewcommand{\chaptername}{第 {\rmfamily\bfseries\thechapter} 章}
\renewcommand{\listfigurename}{插图目录}
\renewcommand{\listtablename}{表格目录}

% 引入常用宏包
\RequirePackage{graphicx}
\RequirePackage{tabularx}\newcolumntype{C}{>{\centering\arraybackslash}X}% 定宽表格的居中对齐样式
\RequirePackage{booktabs}% 表格线宏包
%\abovetopsep=5pt% 表格标题与下文表格的距离
\RequirePackage{tikz}
\usetikzlibrary{positioning}

% 版面设置
\newlength\marginblank
\newlength\leftblank
\newlength\rightblank
\newlength\topblank
\newlength\bottomblank
\setlength\marginblank{10mm}
\setlength\leftblank{\marginblank}
\setlength\rightblank{\marginblank}
\setlength\topblank{2\marginblank}
\setlength\bottomblank{1.6\marginblank}
\RequirePackage[b5paper,top=\topblank,bottom=\bottomblank,left=\leftblank,right=\rightblank]{geometry}
\pagecolor{pagecolor}

\RequirePackage{flowfram}
\setlength\marginparsep{0.02\textwidth}
\newflowframe{0.6\textwidth}{\textheight}{0pt}{0pt}[main]
\setlength\marginparwidth{0.38\textwidth}
\setflowframe*{main}{evenx=0.4\textwidth,margin=outer}
\ifminitoc
    \newdynamicframe{0.38\textwidth}{0.5\textheight}{0.62\textwidth}{0.3\textheight}[chaphead]
    \setdynamicframe*{chaphead}{evenx=0pt,clear}
    \appenddfminitoc*{chaphead}
    \renewcommand{\minitocstyle}{\vspace*{-2mm}\small}
    \enableminitoc
\fi

% 章节标题样式
\RequirePackage{titlesec}
\newcommand{\pchap}[1]{%
    \begin{tikzpicture}[remember picture, overlay]
        \draw[line width=3pt,themecolor] (0,0) -- (\textwidth,0);
        \node[anchor=west,right=-1.4mm] at (0,0.8){\sffamily\huge\color{themecolor} #1};
    \end{tikzpicture}
}
\titleformat{\chapter}{}{%
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=west,right=-1.4mm] at (0,2){\ifnum\value{chapter}>0\sffamily\LARGE\color{themecolor}\chaptertitlename\else\fi};
    \end{tikzpicture}
}{0mm}{\pchap}
\titlespacing*{\chapter}{0pt}{0.14\textheight}{7pt plus 1pt minus 1pt}

\titleformat{\section}{\bfseries\color{themecolor}\LARGE}{\S\,\thesection}{0.5em}{\color{themecolor}\sffamily\mdseries}[\vspace*{-15pt}\color{themecolor}\rule{\linewidth}{2pt}]
\titlespacing*{\section}{0pt}{8pt plus 1pt minus 1pt}{2pt plus 1pt minus 1pt}

\titleformat{\subsection}{\bfseries\color{themecolor}\large}{\thesubsection}{0.5em}{\color{themecolor}\sffamily\mdseries}
\titlespacing*{\subsection}{0pt}{8pt plus 1pt minus 1pt}{4pt plus 1pt minus 1pt}

% 页眉页脚设置
\RequirePackage{titleps}
\renewpagestyle{plain}{%
    \sethead[%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
        \end{tikzpicture}][][]{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
        \end{tikzpicture}}{}{}
    \setfoot{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.south west) rectangle ([shift={(\paperwidth,0.04\paperheight)}]current page.south west);
            \fill[pagecolor] ([shift={(0.86\paperwidth,0.04\paperheight)}]current page.south west) rectangle ([xshift=0.88\paperwidth]current page.south west);
            \node[pagecolor] at ([shift={(0.94\paperwidth,0.02\paperheight)}]current page.south west){\bfseries\upshape\large\thepage};
        \end{tikzpicture}
    }{}{}
}
\newpagestyle{physics}{%
    \sethead[%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
            \node at ([shift={(0.9\paperwidth,-0.04\paperheight)}]current page.north west){\includegraphics[scale=0.9]{npics/headarrow.pdf}};
            \node[anchor=west,pagecolor] at ([shift={(0.049\paperwidth,-0.038\paperheight)}]current page.north west){\sffamily\ifnum\value{chapter}>0\chaptertitlename\hspace{1em}\fi\chaptertitle};
        \end{tikzpicture}][][]{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
            \node at ([shift={(0.1\paperwidth,-0.04\paperheight)}]current page.north west){\includegraphics[scale=0.9]{npics/headarrow.pdf}};
            \node[anchor=east,pagecolor] at ([shift={(0.951\paperwidth,-0.038\paperheight)}]current page.north west){\ifnum\value{section}>0\upshape\textbf{\thesection}\hspace{0.5em}\sffamily\sectiontitle\else\fi};
        \end{tikzpicture}}{}{}
    \setfoot[%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.south west) rectangle ([shift={(\paperwidth,0.04\paperheight)}]current page.south west);
            \fill[pagecolor] ([shift={(0.12\paperwidth,0.04\paperheight)}]current page.south west) rectangle ([xshift=0.14\paperwidth]current page.south west);
            \node[pagecolor] at ([shift={(0.06\paperwidth,0.02\paperheight)}]current page.south west){\bfseries\upshape\large\thepage};
        \end{tikzpicture}][][]{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.south west) rectangle ([shift={(\paperwidth,0.04\paperheight)}]current page.south west);
            \fill[pagecolor] ([shift={(0.86\paperwidth,0.04\paperheight)}]current page.south west) rectangle ([xshift=0.88\paperwidth]current page.south west);
            \node[pagecolor] at ([shift={(0.94\paperwidth,0.02\paperheight)}]current page.south west){\bfseries\upshape\large\thepage};
        \end{tikzpicture}
    }{}{}
}\pagestyle{physics}
\newpagestyle{preface}{%
    \sethead[%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
            \node at ([shift={(0.9\paperwidth,-0.04\paperheight)}]current page.north west){\includegraphics[scale=0.9]{npics/headarrow.pdf}};
        \end{tikzpicture}][][]{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.north west) rectangle ([shift={(\paperwidth,-0.05\paperheight)}]current page.north west);
            \fill[themecolor] ([yshift=-0.055\paperheight]current page.north west) rectangle ([shift={(\paperwidth,-0.06\paperheight)}]current page.north west);
            \node at ([shift={(0.1\paperwidth,-0.04\paperheight)}]current page.north west){\includegraphics[scale=0.9]{npics/headarrow.pdf}};
        \end{tikzpicture}}{}{}
    \setfoot{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[themecolor] (current page.south west) rectangle ([shift={(\paperwidth,0.04\paperheight)}]current page.south west);
        \end{tikzpicture}
    }{}{}
}

% 目录设置
\RequirePackage{titletoc}
\titlecontents{chapter}
              [0pt]
              {\addvspace{3pt}\sffamily\large}
              {\textrm{\textbf{\thecontentslabel}}\hspace{1em}}
              {}
              {\hfill\contentspage[{\makebox[0pt][r]{\color{themecolor}\textrm{\textbf{\thecontentspage}}}}]}
\titlecontents{section}
              [1.5em]
              {\addvspace{0pt}}
              {\S\,\thecontentslabel\hspace{1em}}
              {}
              {\titlerule*[0.7em]{$\cdot$}\contentspage[{\makebox[0pt][r]{\color{themecolor}\bfseries\thecontentspage}}]}
\titlecontents{subsection}
              [3em]
              {\addvspace{0pt}\itshape}
              {\thecontentslabel\hspace{1em}}
              {}
              {\upshape\titlerule*[0.7em]{$\cdot$}\contentspage[{\makebox[0pt][r]{\color{themecolor}\bfseries\thecontentspage}}]}

% 中文支持和字体设置
\RequirePackage{xeCJK}
\setCJKmainfont[BoldFont={Source Han Serif CN Bold},ItalicFont={方正楷体_GBK}]{Source Han Serif CN}
\setCJKsansfont[BoldFont={Source Han Sans CN Bold},ItalicFont={Source Han Sans CN Medium}]{Source Han Sans CN Medium}
\setCJKmonofont[BoldFont={方正仿宋_GBK},ItalicFont={方正仿宋_GBK}]{方正仿宋_GBK}
\linespread{1.2}
\RequirePackage{indentfirst}
\setlength{\parindent}{1.5em}
\RequirePackage{amsmath,amssymb}
\RequirePackage{fourier}
\RequirePackage{mathtools}
\RequirePackage{array}

% 图表注释
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup{labelfont={small,color=themecolor,bf},font=small}
\captionsetup[sub]{labelformat=simple}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\numberwithin{equation}{section}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
\renewcommand{\figurename}{\textsf{\textbf{图}}}
\renewcommand{\tablename}{\textsf{\textbf{表}}}
\makeatletter
\newcommand{\mfcaption}{\def\@captype{figure}\caption}
\newcommand{\mtcaption}{\def\@captype{table}\caption}
\newcommand{\msfcaption}{\def\@captype{figure}\subcaption}
\newcommand{\mstcaption}{\def\@captype{table}\subcaption}
\makeatother

% 生成封面
\renewcommand{\title}{}
\renewcommand{\author}{}
\newtoks\title
\newtoks\author
\title{}
\author{}
\renewcommand{\maketitle}{%
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture, overlay]
        \fill[themecolor] (current page.north west) rectangle ([xshift=0.382\paperwidth]current page.south west);
        \node[opacity=0.2,rotate=45] at ([shift={(0.9\paperwidth,-0.1\paperheight)}]current page.north west){$\displaystyle\oiint_S\boldsymbol{E}\cdot\mathrm{d}\boldsymbol{S}=\frac{q_\text{内}}{\varepsilon_0}$};
        \node[opacity=0.3,rotate=-10] at ([shift={(0.4\paperwidth,-0.45\paperheight)}]current page.north west){$\displaystyle\frac{\rho^2L^2}{m^2}\left(\frac{\mathrm{d}^2\rho}{\mathrm{d}\theta^2}+\rho\right) = -\frac{F(r)}{m}$};
        \node[opacity=0.25,rotate=30] at ([shift={(0.8\paperwidth,-0.8\paperheight)}]current page.north west){$\displaystyle\sum\left(\boldsymbol{F}_i - m_i\boldsymbol{a}_i\right)\cdot\mathrm{\delta}\boldsymbol{r}_i = 0$};
        \fill[pagecolor] ([yshift=-0.368\paperheight]current page.north west) rectangle ([shift={(0.382\paperwidth,-0.378\paperheight)}]current page.north west);
        \fill[themecolor] ([shift={(0.382\paperwidth,-0.368\paperheight)}]current page.north west) rectangle ([shift={(\paperwidth,-0.378\paperheight)}]current page.north west);
        \fill[pagecolor] ([yshift=-0.386\paperheight]current page.north west) rectangle ([shift={(0.382\paperwidth,-0.396\paperheight)}]current page.north west);
        \fill[themecolor] ([shift={(0.382\paperwidth,-0.386\paperheight)}]current page.north west) rectangle ([shift={(\paperwidth,-0.396\paperheight)}]current page.north west);
        \node[anchor=east,themecolor] at ([shift={(0.95\paperwidth,-0.26\paperheight)}]current page.north west){\bfseries\fontsize{40}{40}\selectfont\the\title};
        \node[anchor=east,themecolor] at ([shift={(0.95\paperwidth,-0.46\paperheight)}]current page.north west){\itshape\LARGE\the\author};
        \node[anchor=west,themecolor] at ([shift={(0.4\paperwidth,-0.8\paperheight)}]current page.north west){\begin{minipage}{0.5\paperwidth}
            每一个优秀的人，\\
            都有一段沉默的时光，\\
            那段时光，\\
            是付出了很多努力，却得不到结果的日子，\\
            我们把它叫做扎根
        \end{minipage}};
    \end{tikzpicture}
    \clearpage
    \thispagestyle{preface}
}
% 生成封底
\newcommand{\lastpage}{%
    \newpage\ifoneside\else\ifodd\value{page}\null\thispagestyle{empty}\newpage\else\fi\fi
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture, overlay]
        \fill[themecolor] ([xshift=0.618\paperwidth]current page.north west) rectangle ([xshift=\paperwidth]current page.south west);
    \end{tikzpicture}
}
\AtEndDocument{\lastpage}

% 列表
\RequirePackage{enumitem}
\setlist{%
    topsep=2pt,
    leftmargin=1.5em,
    rightmargin=0em,
    parsep=0pt,
    itemsep=0ex plus 0.1ex
}
\renewcommand{\labelitemi}{\color{themecolor}\textbullet}
\renewcommand{\labelitemii}{\color{themecolor}\normalfont\bfseries\textendash}
\renewcommand{\labelitemiii}{\color{themecolor}\textasteriskcentered}
\renewcommand{\labelitemiv}{\color{themecolor}\textperiodcentered}

% 定义新环境
%\newenvironment{preface}[1][{前\quad 言}]{%
%    \newpage\thispagestyle{preface}
%    \begin{tikzpicture}[remember picture, overlay]
%        \draw[line width=3pt,themecolor] ([shift={(\leftblank,-6)}]current %page.north west) --+ (\textwidth,0);
%        \node[anchor=west,right=-1.4mm,themecolor] at ([shift={(\leftblank,%-5.25)}]current page.north west){\bfseries\huge #1};
%    \end{tikzpicture}
%    \par\vspace*{39mm}
%}{}
\newenvironment{chapitd}{%
    \noindent
    \begin{minipage}{\linewidth}\itshape
}{\end{minipage}}

\newcounter{axiom}[section]
\newenvironment{axiom}[1][{}]{%
    \setlength\parindent{0pt}
    \medskip
    {\par\color{themecolor}\textsf{公理 \stepcounter{axiom}\textrm{\textbf{\theaxiom}}\quad #1}\\ \raisebox{1.6ex}{\rule{\linewidth}{1.5pt}}}\par\vspace*{-7pt}\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
}{{\par\vspace*{-5pt}\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\newcounter{theorem}[section]
\newenvironment{theorem}[1][{}]{%
    \setlength\parindent{0pt}
    \medskip
    {\par\color{themecolor}\textsf{定理 \stepcounter{theorem}\textrm{\textbf{\thetheorem}}\quad #1}\\ \raisebox{1.6ex}{\rule{\linewidth}{1.5pt}}}\par\vspace*{-7pt}\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
}{{\par\vspace*{-5pt}\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\newcounter{principle}[section]
\newenvironment{principle}[1][{}]{%
    \setlength\parindent{0pt}
    \medskip
    {\par\color{themecolor}\textsf{原理 \stepcounter{principle}\textrm{\textbf{\theprinciple}}\quad #1}\\ \raisebox{1.4ex}{\rule{\linewidth}{1.5pt}}}\par\vspace*{-7pt}\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
}{{\par\vspace*{-5pt}\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\newenvironment{law}[1][{定律}]{%
    \setlength\parindent{0pt}
    \medskip
    {\par\color{themecolor}\textsf{#1}\\ \raisebox{1.4ex}{\rule{\linewidth}{1.5pt}}}\par\vspace*{-7pt}\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
}{{\par\vspace*{-5pt}\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\newcounter{inference}[section]
\newenvironment{inference}[1][{}]{%
    \setlength\parindent{0pt}
    \medskip
    {\par\color{themecolor}\textsf{推论 \stepcounter{inference}\textrm{\textbf{\theinference}}\quad #1}\\ \raisebox{1.4ex}{\rule{\linewidth}{1.5pt}}}\par\vspace*{-7pt}\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
}{\par\vspace*{-5pt}{\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\newcounter{qt}[chapter]
\newenvironment{question}[1][{}]{%
    \medskip\small{\par\color{themecolor}\textsf{例题} \stepcounter{qt}\bfseries\thechapter.\theqt\quad #1\\ \raisebox{6pt}{\rule{\linewidth}{1.5pt}}}\vspace*{-3pt}\par
}{}
\newenvironment{anwser}{%
    \small
    {\par\color{themecolor}\textsf{解}\hspace{0.7em}}\itshape
}{}

\newenvironment{notethat}{%
    \setlength\parindent{0pt}
    \smallskip
    {\par\color{themecolor}\raisebox{1.4ex}{\rule{\linewidth}{1.5pt}}}\vspace*{-7pt}\par\itshape
    \setlength{\leftskip}{6pt}
    \setlength{\rightskip}{6pt}
    {\color{themecolor}\textsf{注意}}
}{{\par\vspace*{-5pt}\color{themecolor}\rule{\linewidth}{1.5pt}}\smallskip}

\renewcommand{\emph}[1]{\textit{\color{themecolor}#1}}