#set page(
  "a4",
  flipped: true,
)

#set text(font: ("Inria Sans",))

#let year = {
  datetime.today().year()
}

#for month in range(1, 13) [

  #let month_date = datetime(
    year: year,
    month: month,
    day: 1,
  )

  #let monthly_days = ()

  #for day in range(0, 31) [
    #let month_accumulator = (month_date + duration(days: day))
    #if month_accumulator.month() != month {
      break
    }
    #monthly_days.push(month_accumulator)
  ]

  #align(center)[
    #heading(level: 1)[
      #text(size: 27pt)[
      	#month_date.display("[month repr:long]")
      ]
    ]
  ]


  #let first_monday = {
    int(
    monthly_days.first().display("[weekday repr:monday]")
    )
  }


  #pad(
    y: 20pt,
    table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      rows: (1fr, 1fr, 1fr, 1fr, 1fr),
      inset: 12pt,
      ..range(1, first_monday).map(empty_day => []),
      ..monthly_days.map(
      	day => [
		#grid(
		  columns: (2fr, 1fr),
		  rows: (1fr, 2fr),
		  align: center,
		  gutter: 3pt,
		  day.display("[weekday repr:long]"),
		  day.display("[day padding:none]"),
		)
	      ]
      )
    ),
  )
]
