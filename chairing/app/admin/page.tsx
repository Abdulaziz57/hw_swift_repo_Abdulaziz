'use client'

import { useEffect, useState } from 'react'
import { auth } from '@/lib/firebase'
import { useRouter } from 'next/navigation'

export default function AdminDashboard() {
  const [user, setUser] = useState(null)
  const router = useRouter()

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      if (user && user.email.endsWith('@admin.com')) {
        setUser(user)
      } else {
        router.push('/login')
      }
    })

    return () => unsubscribe()
  }, [router])

  if (!user) {
    return <div>Loading...</div>
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2">
      <h1 className="text-4xl font-bold mb-4">Admin Dashboard</h1>
      <p className="mb-4">Welcome, Admin: {user.email}</p>
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
          <h2 className="text-2xl font-bold mb-2">Seat Usage Statistics</h2>
          {/* Add seat usage statistics here */}
        </div>
        <div className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
          <h2 className="text-2xl font-bold mb-2">IoT Device Management</h2>
          {/* Add IoT device management interface here */}
        </div>
      </div>
    </div>
  )
}

