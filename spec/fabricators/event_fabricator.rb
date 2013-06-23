Fabricator(:event) do
  title     "Capitan Solo birthday"
  schedule  IceCube::Schedule.new.to_yaml
end
