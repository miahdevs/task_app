# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
Task.destroy_all
ProjectContribution.destroy_all
Project.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating users..."
# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Create regular users
users = []
5.times do |i|
  users << User.create!(
    email: "user#{i+1}@example.com",
    password: 'password123',
    password_confirmation: 'password123'
  )
end

puts "Creating categories..."
categories = [
  { 
    title: 'Web Development',
    description: 'Projects focused on creating and maintaining web applications and websites',
    slug: 'web-development'
  },
  { 
    title: 'Mobile Development',
    description: 'Native and cross-platform mobile application development projects',
    slug: 'mobile-development'
  },
  { 
    title: 'Design',
    description: 'User interface design, user experience research, and graphic design projects',
    slug: 'design'
  },
  { 
    title: 'Marketing',
    description: 'Digital marketing campaigns, SEO optimization, and content strategy projects',
    slug: 'marketing'
  },
  { 
    title: 'Research',
    description: 'Market research, competitive analysis, and data analytics projects',
    slug: 'research'
  }
].map do |category_attrs|
  Category.create!(category_attrs)
end

puts "Creating projects..."
projects = []

project_statuses = ['draft', 'active', 'completed', 'on_hold']
project_priorities = [0, 1, 2, 3] # low: 0, medium: 1, high: 2, urgent: 3

15.times do |i|
  project = Project.create!(
    name: "Project #{i+1}",
    description: "This is a sample project description for Project #{i+1}",
    category: categories.sample,
    status: project_statuses.sample,
    priority: project_priorities.sample,
    owner: users.sample,
    deadline: rand(1..30).days.from_now
  )
  projects << project

  # Add some contributors to each project
  rand(1..3).times do
    contributor = (users + [admin]).sample
    ProjectContribution.create!(
      project: project,
      user: contributor
    ) unless project.owner == contributor || project.contributors.include?(contributor)
  end
end

puts "Creating tasks..."
task_statuses = ['pending', 'in_progress', 'completed']

projects.each do |project|
  rand(3..7).times do |i|
    Task.create!(
      name: "Task #{i+1} for #{project.name}",
      description: "This is a detailed description for Task #{i+1} in #{project.name} project",
      status: task_statuses.sample,
      assignee: ([project.owner] + project.contributors).sample,
      project: project,
      deadline: rand(1..20).days.from_now
    )
  end
end

puts "Seed data created successfully!"
puts "\nSample login credentials:"
puts "Admin Email: admin@example.com"
puts "User1 Email: user1@example.com"
puts "Password for all accounts: password123"