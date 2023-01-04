## btc-treasuries.com
Welcome to the btc-treasuries.com repository! This is a Rails application that helps you keep track of BTC transactions by countries, private companies, and public companies. The data for this application is stored in the [data-btc-treasuries.com repository](https://github.com/baxter2/data-btc-treasuries.com), which is a collection of JSON files that can be easily modified by anyone who wants to contribute.

## Development

<details><summary markdown="span">postgresql</summary>

<pre><code>
<b>$ brew install postgresql</b>

<b>$ brew services start postgresql</b>
</pre></code>

</details>

<details><summary markdown="span">redis</summary>

<pre><code>
<b>$ brew install redis</b>

<b>$ brew services start redis</b>
</pre></code>

</details>

```
$ git clone git@github.com:baxter2/btc-treasuries.com.git

$ cd btc-treasuries.com

$ bundle install

$ rails db:create

$ rails db:migrate

$ rails import:countries
$ rails import:private_companies
$ rails import:public_companies

$ ./bin/dev
```

## Contributing
We encourage you to contribute to this project in whatever way you like!

If you have ideas for new features or improvements for the application, feel free to open an issue or create a pull request. If you find any bugs in the application, please report them by opening an issue as well.
