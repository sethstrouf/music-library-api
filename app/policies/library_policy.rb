class LibraryPolicy < ApplicationPolicy
  def show?
    scope.where(id: record.id).exists?
  end
end
