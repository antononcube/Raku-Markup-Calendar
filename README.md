# Markup::Calendar

Raku package with Markup (HTML, Markdown) calendar functions for displaying monthly, yearly, and custom calendars.

### Motivation

The package 
["Text::Calendar"](https://raku.land/zef:antononcube/Text::Calendar), [AAp1], 
provides the core functions for making the calendars in this package.
The packages 
["Data::Translators"](https://raku.land/zef:antononcube/Data::Translators), [AAp2], and 
["Pretty::Table"](https://raku.land/cpan:ANTONOV/Pretty::Table), [ULp1],
provide additional formatting functionalities.

I want to keep "Text::Calendar" lightweight, without any dependencies. Hence I made this separate 
package, "Markup::Calendar", that has more involved dependencies and use-cases.

An "involved use case" is calendar in which some of the days have tooltips and hyperlinks. 

-----

## Installation

From [Zef ecosystem](https://raku.land):

```
zef install Markup::Calendar
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-Markup-Calendar.git
```

-----

## Examples

### Basic HTML calendar

```raku, results=asis
use Markup::Calendar;
use Text::Calendar;

calendar-year(format=>'html')
```
<style>td { vertical-align: top;a}</style><table border="1"><h2>2024</h2><tbody><tr><td><h3>January</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td></tr><tr><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>February</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td><td>4</td></tr><tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td></tr><tr><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td></tr><tr><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr><tr><td>26</td><td>27</td><td>28</td><td>29</td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>March</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td></tr><tr><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td></tr><tr><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td></tr><tr><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td></tr><tr><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td><td>31</td></tr></tbody></table></td></tr><tr><td><h3>April</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td></tr><tr><td>29</td><td>30</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>May</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td></tr><tr><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td></tr><tr><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td></tr><tr><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td></tr><tr><td>27</td><td>28</td><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>June</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td></tr><tr><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td></tr><tr><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td></tr><tr><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td></tr><tr><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td></tr></tbody></table></td></tr><tr><td><h3>July</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td></tr><tr><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>August</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td><td>4</td></tr><tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td></tr><tr><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td></tr><tr><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr><tr><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td><td>31</td><td>  </td></tr></tbody></table></td><td><h3>September</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td></tr><tr><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td></tr><tr><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td></tr><tr><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td></tr><tr><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td></tr><tr><td>30</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td></tr><tr><td><h3>October</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td></tr><tr><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td></tr><tr><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td></tr><tr><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td></tr><tr><td>28</td><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>November</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td></tr><tr><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td></tr><tr><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td></tr><tr><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td></tr><tr><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td><td>  </td></tr></tbody></table></td><td><h3>December</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td></tr><tr><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td></tr><tr><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td></tr><tr><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td></tr><tr><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td></tr><tr><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td></tr></tbody></table>


### HTML calendar with highlights 

Here is an HTML calendar that weekend days are highlighted and with larger font

```raku, results=asis
calendar-year(
    format => 'html', 
    per-row => 4, 
    highlight => (Date.new(2024,1,1)...Date.new(2024,12,31)).grep({ $_.day-of-week ≥ 6 }),
    highlight-style => 'color:orange; font-size:14pt'
)
```
<style>td { vertical-align: top;a}</style><table border="1"><h2>2024</h2><tbody><tr><td><h3>January</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td><span style="color:orange; font-size:14pt">6</span></td><td><span style="color:orange; font-size:14pt">7</span></td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td><span style="color:orange; font-size:14pt">13</span></td><td><span style="color:orange; font-size:14pt">14</span></td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td><span style="color:orange; font-size:14pt">20</span></td><td><span style="color:orange; font-size:14pt">21</span></td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td><span style="color:orange; font-size:14pt">27</span></td><td><span style="color:orange; font-size:14pt">28</span></td></tr><tr><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>February</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td><span style="color:orange; font-size:14pt">3</span></td><td><span style="color:orange; font-size:14pt">4</span></td></tr><tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td><span style="color:orange; font-size:14pt">10</span></td><td><span style="color:orange; font-size:14pt">11</span></td></tr><tr><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td><span style="color:orange; font-size:14pt">17</span></td><td><span style="color:orange; font-size:14pt">18</span></td></tr><tr><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td><span style="color:orange; font-size:14pt">24</span></td><td><span style="color:orange; font-size:14pt">25</span></td></tr><tr><td>26</td><td>27</td><td>28</td><td>29</td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>March</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td><td><span style="color:orange; font-size:14pt">2</span></td><td><span style="color:orange; font-size:14pt">3</span></td></tr><tr><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td><span style="color:orange; font-size:14pt">9</span></td><td><span style="color:orange; font-size:14pt">10</span></td></tr><tr><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td><span style="color:orange; font-size:14pt">16</span></td><td><span style="color:orange; font-size:14pt">17</span></td></tr><tr><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td><span style="color:orange; font-size:14pt">23</span></td><td><span style="color:orange; font-size:14pt">24</span></td></tr><tr><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td><td><span style="color:orange; font-size:14pt">30</span></td><td><span style="color:orange; font-size:14pt">31</span></td></tr></tbody></table></td><td><h3>April</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td><span style="color:orange; font-size:14pt">6</span></td><td><span style="color:orange; font-size:14pt">7</span></td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td><span style="color:orange; font-size:14pt">13</span></td><td><span style="color:orange; font-size:14pt">14</span></td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td><span style="color:orange; font-size:14pt">20</span></td><td><span style="color:orange; font-size:14pt">21</span></td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td><span style="color:orange; font-size:14pt">27</span></td><td><span style="color:orange; font-size:14pt">28</span></td></tr><tr><td>29</td><td>30</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td></tr><tr><td><h3>May</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>1</td><td>2</td><td>3</td><td><span style="color:orange; font-size:14pt">4</span></td><td><span style="color:orange; font-size:14pt">5</span></td></tr><tr><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td><span style="color:orange; font-size:14pt">11</span></td><td><span style="color:orange; font-size:14pt">12</span></td></tr><tr><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td><span style="color:orange; font-size:14pt">18</span></td><td><span style="color:orange; font-size:14pt">19</span></td></tr><tr><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td><span style="color:orange; font-size:14pt">25</span></td><td><span style="color:orange; font-size:14pt">26</span></td></tr><tr><td>27</td><td>28</td><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>June</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td><span style="color:orange; font-size:14pt">1</span></td><td><span style="color:orange; font-size:14pt">2</span></td></tr><tr><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td><span style="color:orange; font-size:14pt">8</span></td><td><span style="color:orange; font-size:14pt">9</span></td></tr><tr><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td><span style="color:orange; font-size:14pt">15</span></td><td><span style="color:orange; font-size:14pt">16</span></td></tr><tr><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td><span style="color:orange; font-size:14pt">22</span></td><td><span style="color:orange; font-size:14pt">23</span></td></tr><tr><td>24</td><td>25</td><td>26</td><td>27</td><td>28</td><td><span style="color:orange; font-size:14pt">29</span></td><td><span style="color:orange; font-size:14pt">30</span></td></tr></tbody></table></td><td><h3>July</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td><span style="color:orange; font-size:14pt">6</span></td><td><span style="color:orange; font-size:14pt">7</span></td></tr><tr><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td><span style="color:orange; font-size:14pt">13</span></td><td><span style="color:orange; font-size:14pt">14</span></td></tr><tr><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td><span style="color:orange; font-size:14pt">20</span></td><td><span style="color:orange; font-size:14pt">21</span></td></tr><tr><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td><span style="color:orange; font-size:14pt">27</span></td><td><span style="color:orange; font-size:14pt">28</span></td></tr><tr><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>August</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>1</td><td>2</td><td><span style="color:orange; font-size:14pt">3</span></td><td><span style="color:orange; font-size:14pt">4</span></td></tr><tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td><span style="color:orange; font-size:14pt">10</span></td><td><span style="color:orange; font-size:14pt">11</span></td></tr><tr><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td><span style="color:orange; font-size:14pt">17</span></td><td><span style="color:orange; font-size:14pt">18</span></td></tr><tr><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td><span style="color:orange; font-size:14pt">24</span></td><td><span style="color:orange; font-size:14pt">25</span></td></tr><tr><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td><td><span style="color:orange; font-size:14pt">31</span></td><td>  </td></tr></tbody></table></td></tr><tr><td><h3>September</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td><span style="color:orange; font-size:14pt">1</span></td></tr><tr><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td><span style="color:orange; font-size:14pt">7</span></td><td><span style="color:orange; font-size:14pt">8</span></td></tr><tr><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td><span style="color:orange; font-size:14pt">14</span></td><td><span style="color:orange; font-size:14pt">15</span></td></tr><tr><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td><span style="color:orange; font-size:14pt">21</span></td><td><span style="color:orange; font-size:14pt">22</span></td></tr><tr><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td><span style="color:orange; font-size:14pt">28</span></td><td><span style="color:orange; font-size:14pt">29</span></td></tr><tr><td>30</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>October</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>1</td><td>2</td><td>3</td><td>4</td><td><span style="color:orange; font-size:14pt">5</span></td><td><span style="color:orange; font-size:14pt">6</span></td></tr><tr><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td><span style="color:orange; font-size:14pt">12</span></td><td><span style="color:orange; font-size:14pt">13</span></td></tr><tr><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td><span style="color:orange; font-size:14pt">19</span></td><td><span style="color:orange; font-size:14pt">20</span></td></tr><tr><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td><span style="color:orange; font-size:14pt">26</span></td><td><span style="color:orange; font-size:14pt">27</span></td></tr><tr><td>28</td><td>29</td><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td><td><h3>November</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>1</td><td><span style="color:orange; font-size:14pt">2</span></td><td><span style="color:orange; font-size:14pt">3</span></td></tr><tr><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td><span style="color:orange; font-size:14pt">9</span></td><td><span style="color:orange; font-size:14pt">10</span></td></tr><tr><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td><span style="color:orange; font-size:14pt">16</span></td><td><span style="color:orange; font-size:14pt">17</span></td></tr><tr><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td><span style="color:orange; font-size:14pt">23</span></td><td><span style="color:orange; font-size:14pt">24</span></td></tr><tr><td>25</td><td>26</td><td>27</td><td>28</td><td>29</td><td><span style="color:orange; font-size:14pt">30</span></td><td>  </td></tr></tbody></table></td><td><h3>December</h3><table border="1"><thead><tr><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th><th>Su</th></tr></thead><tbody><tr><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td><span style="color:orange; font-size:14pt">1</span></td></tr><tr><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td><span style="color:orange; font-size:14pt">7</span></td><td><span style="color:orange; font-size:14pt">8</span></td></tr><tr><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td><span style="color:orange; font-size:14pt">14</span></td><td><span style="color:orange; font-size:14pt">15</span></td></tr><tr><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td><span style="color:orange; font-size:14pt">21</span></td><td><span style="color:orange; font-size:14pt">22</span></td></tr><tr><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td><td><span style="color:orange; font-size:14pt">28</span></td><td><span style="color:orange; font-size:14pt">29</span></td></tr><tr><td>30</td><td>31</td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr></tbody></table></td></tr></tbody></table>


### Standalone calendar file

Here we make a standalone calendar file:

```raku
spurt('example.html', calendar-year(year => 2024, highlight => [3=>3, 5=>24, 9=>9], highlight-style=>'color:red', format=>'html'))
```
```
# True
```

------

## TODO

- [ ] TODO Features
  - [X] DONE Full HTML calendar 
  - [ ] TODO Partial HTML calendar (e.g. equivalent of `cal -3`) 
  - [ ] TODO Full Markdown calendar
  - [ ] TODO Partial Markdown calendar
  - [X] DONE Highlighted days
  - [ ] TODO Tooltips for days
  - [ ] TODO Hyperlinks for days
- [ ] Unit tests
- [ ] Documentation
  - [X] DONE Basic README
  - [ ] TODO Diagrams
  - [ ] TODO Comparisons

------

## References 

[AAp1] Anton Antonov,
[Text::Calendar Raku package](https://github.com/antononcube/Raku-Text-Calendar),
(2024),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[Data::Translators Raku package](https://github.com/antononcube/Raku-Data-Translators),
(2023),
[GitHub/antononcube](https://github.com/antononcube).

[LUp1] Luis F. Uceta,
[Pretty::Table Raku package](https://gitlab.com/uzluisf/raku-pretty-table/),
(2020),
[GitLab/uzluisf](https://gitlab.com/uzluisf/).


