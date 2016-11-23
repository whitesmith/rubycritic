# Core Metrics, Score and Rating

RubyCritic wraps around static analysis gems such as [Reek][2], [Flay][3] and [Flog][4] to provide a quality report of your Ruby code.

Each of these gems are internally wrapped as an **Analyser**, with a collection of **AnalysedModule**s, which give us calculations of key metrics.
The most important ones are **churn**, **complexity**, **cost** and **rating**.

The output of RubyCritic will give you four values to help you judge your code's _odorousness_:

- [**Score**](#score): A generic number representing overall quality of the analysed code
- [**Churn**](#churn-and-complexity): Number of times a file was changed
- [**Complexity**](#churn-and-complexity): Amount of _pain_ in your code
- [**Rating**](#rating): The grade assigned to a file

RubyCritic's **rating** system was inspired by Code Climate's, you can [read more about how that works here][1].
Note that the global **score** is fairly different from Code Climate's GPA, although it serves the same purpose.

## Score

Is a value that ranges from 0 to 100, where higher values are better (less code smells detected) and is intended to provide a quick insight about the overall code quality.

This is basically an average of the calculated [cost](#cost) of each file.
There is a [threshold][6] to avoid very bad modules from having excessive impact.

## Churn and complexity

Churn is very simple to calculate - it is the number of times the file was committed.

Complexity is the output of [Flog][4]. You can [read more about how it works][7], but here's a quick summary:

> It works based on counting your code's ABCs:
>
> A - Assignments. When more objects are assigned, the complexity goes up - foo = 1 + 1.
>
> B - Branches. When code branches, there are multiple paths that it might follow. This also increases it's complexity.
>
> C - Calls. When code calls other code, the complexity increases because they caller and callee are now connected. A call is both a method call or other action like eval or puts.
>
> All code has assignments, branches, and calls. Flog's job is to check that they aren't used excessively or abused.

Both **churn** and **complexity** are presented as a chart:

![RubyCritic overview screenshot](/images/churn-vs-complexity.png)

Each file is represented by a dot. **The closer they are to the bottom-left corner, the better.**
But keep in mind that you cannot reduce churn (well... not unless you re-write your repo's history :neckbeard:), so try to keep the dots as close to the bottom as possible.
Chad made a nice [summary if you want to know more][8] about the meaning behind each quadrant.


## Rating

This is a letter from `A` to `F`, `A` being the best. This serves as a baseline to tell you how *smelly* a file is.
Generally `A`'s & `B`'s are good enough, `C`'s serve as a warning and `D`'s & `F`'s are the ones you should be fixing.

**Rating** is simply [a conversion][5] from the calculated **cost** to a letter.

![RubyCritic code index screenshot](/images/rating.png)

### Cost

The definition of this **cost** varies from tool to tool, but it's always a non-negative number, with high values indicating worse smells.
The **complexity** of a file also (slightly) affects its final cost.


[1]: https://gist.github.com/brynary/21369b5892525e1bd102
[2]: https://github.com/troessner/reek
[3]: https://github.com/seattlerb/flay
[4]: https://github.com/seattlerb/flog
[5]: https://github.com/whitesmith/rubycritic/blob/master/lib/rubycritic/core/rating.rb
[6]: https://github.com/whitesmith/rubycritic/blob/master/lib/rubycritic/core/analysed_modules_collection.rb
[7]: http://www.railsinside.com/tutorials/487-how-to-score-your-rails-apps-complexity-before-refactoring.html
[8]: https://github.com/chad/turbulence#hopefully-meaningful-metrics
