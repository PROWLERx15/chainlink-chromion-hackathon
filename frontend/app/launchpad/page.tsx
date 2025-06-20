import { Starfield } from "@/components/starfield"
import { LaunchpadInterface } from "@/components/launchpad/launchpad-interface"
import { getCurrentUser } from "@/lib/auth"

export default async function LaunchpadPage() {
  // Get current user if logged in (will be null if not logged in)
  const user = await getCurrentUser()

  return (
    <div className="min-h-screen bg-space-black text-white relative overflow-hidden">
      <Starfield />
      <div className="pt-20 pb-12 relative z-10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-8">
            <h1 className="text-4xl md:text-5xl font-bold mb-4 neon-text font-orbitron">MISSION LAUNCHPAD</h1>
            <p className="text-xl text-gray-300 max-w-3xl mx-auto font-tech">
              {user ? `Welcome back, Captain ${user.email?.split("@")[0]}` : "Prepare for interstellar token transfer"}
            </p>
          </div>

          <LaunchpadInterface userId={user?.id} />
        </div>
      </div>
    </div>
  )
}
