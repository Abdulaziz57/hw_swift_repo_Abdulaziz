import { NextResponse } from 'next/server'

export async function GET() {
  // Fetch seat data from your database or IoT devices
  const seatData = [
    { id: 1, occupied: false, x: -70.9, y: 42.35 },
    { id: 2, occupied: true, x: -70.91, y: 42.36 },
    // Add more seat data
  ]

  return NextResponse.json(seatData)
}

export async function POST(request: Request) {
  const data = await request.json()
  // Update seat data in your database or IoT devices
  console.log('Updating seat data:', data)

  return NextResponse.json({ success: true })
}

