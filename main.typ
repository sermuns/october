#import "calendar.typ": calendar

#set page(
  "a4",
  flipped: true,
)

#show: calendar.with(
  year: datetime.today().year(),
)