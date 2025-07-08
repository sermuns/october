#let calendar(year: "", body) = {
  set document(title: str(year) + " calendar")
  set page(margin: 2cm)
  set text(lang: "sv")

  let month-names = (
    "Januari",
    "Februari",
    "Mars",
    "April",
    "Maj",
    "Juni",
    "Juli",
    "Augusti",
    "September",
    "Oktober",
    "November",
    "December",
  )

  for month-num in range(1, 13) {
    let month_date = datetime(
      year: year,
      month: month-num,
      day: 1,
    )

    let monthly_days = ()
    for day in range(0, 31) {
      let month_accumulator = (month_date + duration(days: day))
      if month_accumulator.month() != month-num {
        break
      }
      monthly_days.push(month_accumulator)
    }

    {
      set align(center)
      set text(size: 27pt, weight: "bold")
      [#month-names.at(month-num - 1) #year]
    }

    let first_monday = {
      int(monthly_days.first().display("[weekday repr:monday]"))
    }

    show table.cell.where(y: 0): strong
    table(
      columns: (1fr,) * 7,
      rows: (0.4fr,) + 5 * (1fr,),
      inset: 1em,
      table.header(
        [Måndag], [Tisdag], [Onsdag], [Torsdag], [Fredag], [Lördag], [Söndag]
      ),
      ..range(1, first_monday).map(empty_day => []),
      ..monthly_days.map(day => [#day.display("[day padding:none]")]),
    )
  }
}

#set page(
  "a4",
  flipped: true,
)

#show: calendar.with(
  year: datetime.today().year(),
)
